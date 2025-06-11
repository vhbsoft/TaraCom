# =========================================
# Script Name: simu_comp_link_capacity.sh
#
# Summary:
#     This script varies the compression link capacity (0.5–10 Mbps) to examine its impact on reset delay.
#     For each capacity and entropy setting ("l", "h"), it:
#       1. Runs the ns-3 compression-exp simulation with fixed payload and packet number.
#       2. Calls getDelay.py to extract TCP RST timestamps and calculate delay.
#       3. Appends the delay value to rst_delay_results_link.txt.
#
# Input Parameters:
#     - Link capacity: 0.5, 1, ..., 10 (Mbps)
#     - Entropy: l (low) or h (high)
#
# Output File:
#     - rst_delay_results_link.txt (CSV-style delay per capacity/entropy combo)
#
# Dependencies:
#     - ns3
#     - getDelay.py
# =========================================

#!/bin/bash
outputFile="rst_delay_results_link.txt" # set the destination file
> $outputFile # clean the destination file

simu="link"

for capacity in 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6.5 7 7.5 8 8.5 9 9.5 10; do
  for entropy in l h; do
    ./ns3 run compression-exp -- --filename=myconfig.txt --packetNumber=1000 --compLinkCap=${capacity}Mbps --payload=1100 --entropy=$entropy --threshold=20 --queueSize=10000
    # get the results
    # python3 getSimuRes.py $outputFile $entropy $capacity $queueSize

    # delay based
    python3 getDelay.py $entropy $capacity $simu
  done
done
