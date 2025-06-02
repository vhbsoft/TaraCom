
#!/bin/bash
lossRateFile="lossrate_output" # set the destination file
> $lossRateFile # clean the destination file
echo "capacity,1,2,3,4,5,6," >> $lossRateFile # Append the line to the output file

for capacity in 1 2 3 4 5 6 7 8 9 10; do
  # packetNum = n + n_i
  ./ns3 run compression-exp -- --filename=myconfig.txt --payload=1100 --packetNumber=6000 --compLinkCap=${capacity}Mbps --entropy=l --queueSize=1
  
  # get the results
  echo -n "${capacity}," >> $lossRateFile
  for lambda in 1 2 3 4 5 6; do
    > "superpacket_output"
    python3 getSuperPacket.py 0 $lambda
    python3 countSpLossRate.py $lossRateFile $lambda
  done
  echo "" >> $lossRateFile
done
