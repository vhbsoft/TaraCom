#!/bin/bash
# =========================================
# Script Name: simu_traffic_shaper.sh
#
# Summary:
#     This script automates a 2D experiment:
#       For link capacities 1–10 Mbps and 6 values of shaping parameter λ,
#       it:
#         1. Runs an ns-3 simulation.
#         2. Applies getSuperPacket.py with λ to extract result.
#         3. Uses countSpLossRate.py to compute loss rate and append to CSV.
#
# Input Parameters:
#     - Link capacity: 1–10 Mbps
#     - Lambda: 1–6
#
# Output File (in results/traffic_shaper/):
#     - lossrate_output (CSV format: capacity, loss for λ=1~6)
#
# Dependencies:
#     - ns3 (via common.sh)
#     - getSuperPacket.py
#     - countSpLossRate.py
# =========================================

source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
enter_run_dir traffic_shaper

lossRateFile="lossrate_output" # set the destination file
> $lossRateFile # clean the destination file
echo "capacity,1,2,3,4,5,6," >> $lossRateFile # Append the line to the output file

for capacity in 1 2 3 4 5 6 7 8 9 10; do
  # packetNum = n + n_i
  run_sim compression-exp --payload=1100 --packetNumber=6000 --compLinkCap=${capacity}Mbps --entropy=l --queueSize=1
  
  # get the results
  echo -n "${capacity}," >> $lossRateFile
  for lambda in 1 2 3 4 5 6; do
    > "superpacket_output"
    python3 "$analysis/getSuperPacket.py" 0 $lambda
    python3 "$analysis/countSpLossRate.py" $lossRateFile $lambda
  done
  echo "" >> $lossRateFile
done
