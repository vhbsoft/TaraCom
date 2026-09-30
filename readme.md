# TaraCom on ns-3.48

TaraCom's `compression-exp` simulation models a compressing point-to-point link between a UDP probe sender and receiver. It uses the contributed `compression` and `experiment` modules in this repository. The source is based on the original [TaraCom ns-3 fork](https://github.com/arbie333/ns-3-dev) and targets the upstream [ns-3.48 release](https://gitlab.com/nsnam/ns-3-dev/-/tags/ns-3.48).

## Build

On Fedora or Ubuntu, run:

```bash
./setup.sh
```

The script installs the required C++, CMake, MPI, zlib, and TShark packages if needed, clones the ns-3.48 tag into `../ns-3.48-taracom`, copies the two contributed modules and the simulation, then builds `compression-exp`. To use an existing checkout at the ns-3.48 tag, pass its path to `setup.sh`. It must be a separate checkout because setup installs files into it. ns-3.48 requires CMake 3.25 or newer, Python 3.10 or newer, and a supported C++ compiler.

## Run

Run commands from the ns-3 checkout created by setup:

```bash
cd ../ns-3.48-taracom
./ns3 run compression-exp -- --filename=myconfig.txt --packetNumber=100 --compLinkCap=2Mbps --payload=1100 --entropy=l --queueSize=100
```

The included `myconfig.txt` defines the UDP and TCP ports and the results filename. The simulation writes packet reception times to `compression_link_output` and produces PCAP traces. The five supported `simu_*.sh` sweep scripts and their Python helpers are copied into the checkout; run them there. They can take considerably longer than the example above.

`simu_comp_multi_syn.sh` is not supported: its `compression-multi-syn` simulation source is absent from this repository and the original fork. The three TCP headers retained under `src/internet/model` are historical ns-3.38 copies and are not installed into ns-3.48.
