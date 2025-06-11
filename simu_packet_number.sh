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
# Output File:
#     - rst_delay_results_packetNum.txt
#
# Dependencies:
#     - ns3
#     - getDelay.py
# =========================================

#!/bin/bash

# outputFile="packet_number" # set the destination file
outputFile="rst_delay_results_packetNum.txt"
> $outputFile # clean the destination file

simu="packetNum"

for packetNum in 250 500 750 1000 1250 1500 1750 2000 2250 2500 2750 3000; do
  for entropy in l h; do
    ./ns3 run compression-exp -- --filename=myconfig.txt --payload=1100 --packetNumber=$packetNum --compLinkCap=2Mbps --entropy=$entropy --queueSize=10000
    
    # loss rate based
    # python3 getSimuRes.py $outputFile $entropy $packetNum

    # delay based
    python3 getDelay.py $entropy $packetNum $simu

  done
done
