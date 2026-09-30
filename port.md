# ns-3.48 port

- Bundled the fork's `compression` and `experiment` modules; fixed `Ptr` null comparisons and linked MPI and zlib.
- `setup.sh` now builds against upstream ns-3.48 with CMake, copies the sample config and sweep helpers, and leaves upstream TCP headers intact.
- `getDelay.py` now uses TShark instead of `pyshark`.
- Verified a clean build, low and high entropy runs, and the queue-size sweep. `compression-multi-syn` remains unavailable because its source is missing.
