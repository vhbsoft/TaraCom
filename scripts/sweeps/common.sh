# Shared setup for the sweep scripts. Source it; don't run it directly.
#
# Sweeps run from this repo. Each one works in results/<name>/, and the
# simulation writes its PCAPs to results/<name>/pcap/.
# Set NS3_DIR to use an ns-3 checkout other than ../ns-3.48-taracom.

repo="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
ns3_dir="$(cd -- "${NS3_DIR:-$repo/../ns-3.48-taracom}" && pwd)" || {
    echo "ns-3 checkout not found; run setup.sh or set NS3_DIR." >&2
    exit 1
}
analysis="$repo/scripts/analysis"
config="$repo/config/myconfig.txt"

# usage: enter_run_dir <name>
enter_run_dir() {
    run_dir="$repo/results/$1"
    mkdir -p "$run_dir"
    cd "$run_dir" || exit 1
}

# usage: run_sim <program> <simulation args...>
run_sim() {
    local prog=$1
    shift
    "$ns3_dir/ns3" run "$prog" --cwd="$run_dir" -- --filename="$config" "$@"
}
