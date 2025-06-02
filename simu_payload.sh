
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
