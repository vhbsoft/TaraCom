# =========================================
# Script Name: simu_payload.sh
#
# Summary:
#     This script analyzes how payload size affects performance (e.g., loss rate).
#     For each payload, entropy, and queueSize:
#       1. Runs ns-3 simulation.
#       2. Calculates loss via getSimuRes.py and appends result.
#
# Input Parameters:
#     - Payload: 50–1100 bytes
#     - Entropy: l, h
#     - Queue size: 1, 60
#
# Output File:
#     - packet_size
#
# Dependencies:
#     - ns3
#     - getSimuRes.py
# =========================================

#!/bin/bash

outputFile="packet_size" # set the destination file
> $outputFile # clean the destination file

for payload in 50 100 500 600 700 800 900 1000 1100; do
  for entropy in l h; do
    for queueSize in 1 60; do
      ./ns3 run compression-exp -- --filename=myconfig.txt --packetNumber=10000 --compLinkCap=2Mbps --payload=$payload --entropy=$entropy --queueSize=$queueSize
      # get the results
      python3 getSimuRes.py $outputFile $entropy $payload $queueSize
    done
  done
done
