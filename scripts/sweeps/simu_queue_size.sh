#!/bin/bash
# =========================================
# Script Name: simu_queue_size.sh
#
# Summary:
#     This script evaluates how queue size impacts TCP RST delay.
#     For each queue size:
#       1. Runs the ns-3 simulation with fixed parameters.
#       2. Uses getDelay.py to compute and store delay.
#
# Input Parameters:
#     - Queue size: 1000 (or more, commented)
#     - Entropy: l
#
# Output File (in results/queue_size/):
#     - rst_delay_results_qsize.txt
#
# Dependencies:
#     - ns3 (via common.sh)
#     - getDelay.py
# =========================================

source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
enter_run_dir queue_size

outputFile="rst_delay_results_qsize.txt" # set the destination file
> $outputFile # clean the destination file

simu="qsize"

# for queueSize in 1000 2000 3000 4000 4500 4600 4700 4800 4900 5000 6000 7000 8000 9000 10000; do
for queueSize in 1000; do
  for entropy in l; do
    run_sim compression-exp --packetNumber=1000 --compLinkCap=2Mbps --payload=1100 --entropy=$entropy --threshold=20 --queueSize=$queueSize
    
    # get the results
    # python3 "$analysis/getSimuRes.py" $outputFile $entropy $capacity $queueSize

    # delay based
    python3 "$analysis/getDelay.py" $entropy $queueSize $simu
  done
done
