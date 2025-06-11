# =========================================
# Script Name: multiSYN_lossrate.py
#
# Summary:
#     Extracts TCP SYN packets from a .pcap file, filtering by entropy and port.
#     Saves timestamped log to a .txt file for loss rate analysis.
#
# Input File: pcap trace (e.g., compression_link_l-3-0.pcap)
# Output File: SYN packet log (e.g., multiSYN_output_loss_rate_l.txt)
# Invoked by: simu_comp_multi_syn.sh
# Example:
#     python multiSYN_lossrate.py l 10000
# Output Files: output_txt
# =========================================

import pyshark
import sys
import os

# Ensure correct usage
if len(sys.argv) < 2:
    print("Usage: python script.py <entropy> [r <count>]")
    sys.exit(1)

# Get entropy argument ("l" or "h")
entropy = sys.argv[1]
if entropy not in ["l", "h"]:
    print("Error: Entropy must be 'l' or 'h'.")
    sys.exit(1)

# Check for optional 'r' argument with a count
count_rst = 10000000  # Default is None (no limit)
if len(sys.argv) > 2:
    count_rst = int(sys.argv[2])  # Set count limit
    print(count_rst)

# Input and output file names
input_pcap = f"compression_link_{entropy}-3-0.pcap"
output_txt = f"multiSYN_output_loss_rate_{entropy}.txt"

# Set target port range (6000 - 7000)
target_ports = range(6000, 7001)

# Define display filter based on count_rst
display_filter = "tcp.flags.syn == 1"
if count_rst is not None:
    display_filter = "(tcp.flags.syn == 1 or tcp.flags.reset == 1)"

# Read PCAP file and filter for TCP SYN (and optionally RST) packets
cap = pyshark.FileCapture(input_pcap, display_filter=display_filter)

# Store timestamps for sequence numbers
syn_timestamps = {}

# Track the number of rows written to output
rows_written = 0

# Iterate through packets to extract relevant data
for packet in cap:
    if rows_written >= count_rst:  # Stop when we have written enough rows
        break

    try:
        if hasattr(packet, 'tcp'):
            dst_port = int(packet.tcp.dstport)  # Get destination port
            if dst_port in target_ports:  # Check if within target range
                # Get the real TCP sequence number
                seq_num = int(packet.tcp.seq_raw) if hasattr(packet.tcp, "seq_raw") else int(packet.tcp.seq)
                timestamp = float(packet.sniff_time.timestamp())  # Get timestamp

                if seq_num not in syn_timestamps:
                    syn_timestamps[seq_num] = []  # Create a list for timestamps

                syn_timestamps[seq_num].append(timestamp)  # Store all timestamps
    except (AttributeError, ValueError):
        continue  # Skip invalid packets

cap.close()  # Close the pcap file

# Sort timestamps for each sequence number
for seq in syn_timestamps:
    syn_timestamps[seq].sort()

# Save the results to a text file
with open(output_txt, "w") as f:
    for seq in sorted(syn_timestamps.keys()):  # Iterate over the sequence numbers in sorted order
        for ts in syn_timestamps[seq]:
            if rows_written >= count_rst:  # Stop writing when limit is reached
                break

            f.write(f"{seq}\t{timestamp}\n")
            rows_written += 1