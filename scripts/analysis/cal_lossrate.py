# =========================================
# Script Name: cal_lossrate.py
#
# Summary:
#     Calculates packet loss rate based on received packet logs.
#     Typically used after running ns-3 simulation and extracting SYN packets.
#
# Input File: SYN packet log (e.g., multiSYN_output_loss_rate_l.txt)
# Output File: CSV-style summary (e.g., multi_syn_output.txt)
# Invoked by: simu_comp_multi_syn.sh
# Example:
#     python cal_lossrate.py multiSYN_output_loss_rate_l.txt 40 25 2 l multi_syn_output.txt
# Input Files: input_file
# Output Files: output_file
# =========================================

import sys
import csv
import os

# Ensure correct usage
if len(sys.argv) < 7:
    print("Usage: python calculate_loss.py <input_file> <p> <n> <capacity> <entropy> <output_file>")
    sys.exit(1)

# Get input arguments
input_file = sys.argv[1]

try:
    p = float(sys.argv[2])          # Convert p to a float (same as total_num)
    n = int(sys.argv[3])            # Convert n to an integer
    capacity = float(sys.argv[4])   # Convert capacity to a float
    entropy = sys.argv[5].lower()   # Read entropy and convert to lowercase
    if entropy not in ["l", "h"]:
        raise ValueError("Entropy must be 'l' (low) or 'h' (high)")
except ValueError as e:
    print(f"Error: Invalid number format or entropy value - {e}")
    print(f"Received arguments: p='{sys.argv[2]}', n='{sys.argv[3]}', capacity='{sys.argv[4]}', entropy='{sys.argv[5]}'")
    sys.exit(1)

output_file = sys.argv[6]  # Output file

# Count the actual number of lines in the file
actual_count = 0
try:
    with open(input_file, "r") as f:
        for line in f:
            actual_count += 1
except FileNotFoundError:
    print(f"Error: File '{input_file}' not found.")
    sys.exit(1)

# Compute the loss rate
loss_count = p - actual_count  # p is now used as total_num
loss_rate = (loss_count / p) * 100 if p > 0 else 0

# Check if file exists to determine if we need to write headers
file_exists = os.path.isfile(output_file)

# Append results to CSV file
try:
    with open(output_file, "a", newline="") as f:
        writer = csv.writer(f)
        
        # Write header if file doesn't exist
        if not file_exists:
            writer.writerow(["loss_rate", "p", "n", "capacity", "entropy"])
        
        # Write data row
        writer.writerow([f"{loss_rate:.2f}", p, n, capacity, entropy])
    
    print(f"Results appended to {output_file}")
except IOError:
    print(f"Error: Could not write to '{output_file}'.")

# Print results to console as well
print(f"Total expected packets (p): {p}")
print(f"Total received packets: {actual_count}")
print(f"Total lost packets: {loss_count}")
print(f"Packet loss rate: {loss_rate:.2f}%")
print(f"Entropy: {entropy}")
