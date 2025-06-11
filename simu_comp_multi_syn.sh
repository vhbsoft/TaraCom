# =========================================
# Script Name: simu_comp_multi_syn.sh
#
# Summary:
#     This script tests multiple (p, n) input combinations using SYN and UDP packets.
#     For each entropy setting ("l", "h"), it:
#       1. Runs ns-3 simulation with specific p, n values.
#       2. Uses multiSYN_lossrate.py to extract SYN packet log.
#       3. Runs cal_lossrate.py to compute and append loss rate.
#
# Input Parameters:
#     - Entropy: l or h
#     - (p, n): defined statically in 'pairs'
#     - Capacity: fixed at 2 Mbps
#
# Output File:
#     - multi_syn_output.txt (appended with loss rates per setting)
#
# Dependencies:
#     - ns3
#     - multiSYN_lossrate.py
#     - cal_lossrate.py
# =========================================

p=200
n=10
capacity=2

rm -f multi_syn_output.txt  # Delete multi_syn_output.txt at the beginning

for entropy in l h; do
    for capacity in 2; do
        # Define pairs of p and n
        pairs=(
            "40 25"
        )

        for pair in "${pairs[@]}"; do
            # Extract p (numbers of SYN) and n (numbers of UDP) values from the pair
            read -r p n <<< "$pair"

            echo "Running with entropy=$entropy, capacity=$capacity, p=$p, n=$n"

            ./ns3 run compression-multi-syn -- --filename=myconfig.txt --compLinkCap=${capacity}Mbps --payload=1100 --entropy=$entropy --p=$p --n=$n
            python3 multiSYN_lossrate.py $entropy
            python3 cal_lossrate.py multiSYN_output_loss_rate_$entropy.txt $p $n $capacity $entropy multi_syn_output.txt
        done
    done
done


# queue size = 60 (default)
# total number packet = 6000
# number of syn = 200
# 10
# 10-2-10
