
#!/bin/bash
outputFile="rst_delay_results_qsize.txt" # set the destination file
> $outputFile # clean the destination file

simu="qsize"

# for queueSize in 1000 2000 3000 4000 4500 4600 4700 4800 4900 5000 6000 7000 8000 9000 10000; do
for queueSize in 1000; do
  for entropy in l; do
    ./ns3 run compression-exp -- --filename=myconfig.txt --packetNumber=1000 --compLinkCap=2Mbps --payload=1100 --entropy=$entropy --threshold=20 --queueSize=$queueSize
    
    # get the results
    # python3 getSimuRes.py $outputFile $entropy $capacity $queueSize

    # delay based
    python3 getDelay.py $entropy $queueSize $simu
  done
done
