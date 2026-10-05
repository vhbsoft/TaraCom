# TaraCom on ns-3.48

TaraCom's `compression-exp` simulation models a compressing point-to-point link between a UDP probe sender and receiver. It uses the contributed `compression` and `experiment` modules in this repository. The source is based on the original [TaraCom ns-3 fork](https://github.com/arbie333/ns-3-dev) and targets the upstream [ns-3.48 release](https://gitlab.com/nsnam/ns-3-dev/-/tags/ns-3.48).

## Build

On Fedora or Ubuntu, run:

```bash
./setup.sh
```

The script installs the required C++, CMake, MPI, zlib, and TShark packages if needed, clones the ns-3.48 tag into `../ns-3.48-taracom`, copies the two contributed modules and the simulation, then builds `compression-exp`. To use an existing checkout at the ns-3.48 tag, pass its path to `setup.sh`. It must be a separate checkout because setup installs files into it. ns-3.48 requires CMake 3.25 or newer, Python 3.10 or newer, and a supported C++ compiler.

## Layout

```
config/myconfig.txt     simulation config (ports, link capacity, output file, compression on/off)
contrib/                compression and experiment ns-3 modules, installed by setup.sh
scratch/                compression-exp simulation, installed by setup.sh
scripts/sweeps/         parameter sweep scripts (simu_*.sh) and their shared common.sh
scripts/analysis/       Python helpers the sweeps call to parse outputs and PCAPs
results/<sweep>/        output of new sweep runs, with PCAPs in pcap/ (gitignored)
results/archive/        results from earlier experiments
docs/                   porting notes
attic/                  unused leftovers, kept for reference
```

## Run

To run one simulation, work from the ns-3 checkout that setup created:

```bash
cd ../ns-3.48-taracom
./ns3 run compression-exp -- --filename=../TaraCom/config/myconfig.txt --packetNumber=100 --compLinkCap=2Mbps --payload=1100 --entropy=l --queueSize=100
```

`config/myconfig.txt` defines the UDP and TCP ports, the results filename and `compression_enabled` (`true` or `false`). Set `compression_enabled` to `false` to get an uncompressed baseline. The simulation writes packet reception times to `compression_link_output` and PCAP traces to `pcap/`, both in the directory where it runs.

The five supported sweep scripts run from this repository:

```bash
scripts/sweeps/simu_queue_size.sh
```

Each sweep runs inside `results/<sweep>/`, for example `results/queue_size/`, so its outputs, PCAPs and summary files stay together. By default the sweeps use the checkout at `../ns-3.48-taracom`; set `NS3_DIR` to use another one. Sweeps can take considerably longer than the single run above. After changing anything under `contrib/` or `scratch/`, rerun `setup.sh` so the checkout gets the new sources.

`simu_comp_multi_syn.sh` is not supported: its `compression-multi-syn` simulation source is absent from this repository and the original fork. The three TCP headers in `attic/ns-3.38-tcp-headers/` are historical ns-3.38 copies and are not installed into ns-3.48.
