#!/bin/bash
# =========================================
# Script Name: simu_packet_number.sh
#
# Summary:
#     This script explores how varying the total number of packets affects delay.
#     For each (packet number, entropy) combination:
#       1. Runs the ns-3 compression-exp simulation.
#       2. Runs getDelay.py to calculate TCP RST delay.
#
# Input Parameters:
#     - Packet numbers: 250–3000
#     - Entropy: l, h
#
# Output File (in results/packet_number/):
#     - rst_delay_results_packetNum.txt
#
# Dependencies:
#     - ns3 (via common.sh)
#     - getDelay.py
# =========================================

source "$(dirname -- "${BASH_SOURCE[0]}")/common.sh"
enter_run_dir packet_number


# outputFile="packet_number" # set the destination file
outputFile="rst_delay_results_packetNum.txt"
> $outputFile # clean the destination file

simu="packetNum"

for packetNum in 250 500 750 1000 1250 1500 1750 2000 2250 2500 2750 3000; do
  for entropy in l h; do
    run_sim compression-exp --payload=1100 --packetNumber=$packetNum --compLinkCap=2Mbps --entropy=$entropy --queueSize=10000
    
    # loss rate based
    # python3 "$analysis/getSimuRes.py" $outputFile $entropy $packetNum

    # delay based
    python3 "$analysis/getDelay.py" $entropy $packetNum $simu

  done
done
