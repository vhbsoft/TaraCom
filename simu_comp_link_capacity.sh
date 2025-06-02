
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
