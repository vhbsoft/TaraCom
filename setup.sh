#!/usr/bin/env bash
set -euo pipefail

if [[ $# -gt 1 || ${1:-} == --help || ${1:-} == -h ]]; then
    echo "Usage: $0 [ns-3.48-taracom-directory]"
    echo "Installs build dependencies, including MPI and zlib, using dnf or apt-get (sudo if needed)."
    echo "Defaults to a separate ns-3.48 checkout beside TaraCom."
    [[ $# -le 1 ]] && exit 0
    exit 1
fi

if command -v dnf >/dev/null 2>&1; then
    packages=(git cmake gcc-c++ make python3 openmpi-devel zlib-devel wireshark-cli)
    missing_packages=()
    for package in "${packages[@]}"; do
        if [[ $package == zlib-devel ]] && rpm -q --whatprovides 'pkgconfig(zlib)' >/dev/null 2>&1; then
            continue
        fi
        if ! rpm -q "$package" >/dev/null 2>&1; then
            missing_packages+=("$package")
        fi
    done
    install_command=(dnf install -y)
elif command -v apt-get >/dev/null 2>&1; then
    packages=(git cmake g++ make python3 libopenmpi-dev openmpi-bin zlib1g-dev tshark)
    missing_packages=()
    for package in "${packages[@]}"; do
        if [[ $(dpkg-query -W -f='${Status}' "$package" 2>/dev/null || true) != "install ok installed" ]]; then
            missing_packages+=("$package")
        fi
    done
    install_command=(apt-get install -y)
else
    echo "Unsupported package manager. This script supports dnf and apt-get." >&2
    exit 1
fi

if [[ ${#missing_packages[@]} -gt 0 ]]; then
    privilege_command=()
    if [[ $EUID -ne 0 ]]; then
        if ! command -v sudo >/dev/null 2>&1; then
            echo "Installing dependencies requires sudo or running as root." >&2
            exit 1
        fi
        privilege_command=(sudo)
    fi
    echo "Installing missing dependencies: ${missing_packages[*]}"
    if [[ ${install_command[0]} == apt-get ]]; then
        "${privilege_command[@]}" apt-get update
    fi
    "${privilege_command[@]}" "${install_command[@]}" "${missing_packages[@]}"
fi

for mpi_bin in /usr/lib64/openmpi/bin /usr/lib/openmpi/bin; do
    if [[ -x "$mpi_bin/mpicxx" ]]; then
        export PATH="$mpi_bin:$PATH"
        break
    fi
done

if ! command -v mpicxx >/dev/null 2>&1; then
    echo "Open MPI was installed, but mpicxx could not be found." >&2
    exit 1
fi

for tool in git cmake c++; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "Missing required tool: $tool" >&2
        exit 1
    fi
done

taracom_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ns3_dir="${1:-$taracom_dir/../ns-3.48-taracom}"

if [[ ! -e "$ns3_dir" ]]; then
    git clone --depth 1 --branch ns-3.48 https://gitlab.com/nsnam/ns-3-dev.git "$ns3_dir"
fi

if [[ $(git -C "$ns3_dir" describe --tags --exact-match HEAD 2>/dev/null || true) != ns-3.48 ]]; then
    echo "Expected an ns-3.48 checkout at $ns3_dir." >&2
    exit 1
fi

for module in compression experiment; do
    mkdir -p "$ns3_dir/contrib/$module"
    cp -a "$taracom_dir/contrib/$module/." "$ns3_dir/contrib/$module/"
done
mkdir -p "$ns3_dir/scratch/compression-link"
cp -- "$taracom_dir/scratch/compression-link/compression-exp.cc" \
    "$ns3_dir/scratch/compression-link/compression-exp.cc"

cmake -S "$ns3_dir" -B "$ns3_dir/cmake-cache" \
    -DCMAKE_BUILD_TYPE=Release \
    -DNS3_EXAMPLES=OFF \
    -DNS3_TESTS=OFF \
    -DNS3_MPI=ON \
    "-DMPI_C_COMPILER=$(command -v mpicc)" \
    "-DMPI_CXX_COMPILER=$(command -v mpicxx)" \
    '-DNS3_ENABLED_MODULES=applications;point-to-point;internet-apps;compression;experiment;mpi'

cmake --build "$ns3_dir/cmake-cache" \
    --target scratch_compression-link_compression-exp \
    --parallel "${TARACOM_BUILD_JOBS:-4}"

echo "TaraCom compiled successfully in $ns3_dir/build."
echo "Run sweeps from $taracom_dir with scripts/sweeps/<name>.sh; results land in results/<name>/."
