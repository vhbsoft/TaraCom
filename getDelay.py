# =========================================
# Script Name: getDelay.py
#
# Summary:
#     This script parses a .pcap file to measure the delay between the first
#     two TCP RST packets (often used to signal the end of a simulation).
#     It computes ΔT (delay in seconds) and appends the result to a delay output file.
#
# Input File: compression_link_<entropy>-3-0.pcap
# Output File: output/delay_<entropy>_<packet_number>_<simu>
#
# Usage:
#     python getDelay.py l 40 qos
#         - 'l' = low entropy
#         - 40 = number of packets
#         - qos = simulation label
#
# Output:
#     delay_<entropy>_<packet_number>_<simu>: contains the delay in seconds
#
# Called by: simu_traffic_shaper.sh
# =========================================

import sys
import pyshark

# Get command-line arguments
if len(sys.argv) < 4:
    print("Usage: python script.py <entropy> <packet_number> <simulation_type>")
    sys.exit(1)

entropy = sys.argv[1]  # "h" or "l"
packet_number = sys.argv[2]  # Packet number
simu = sys.argv[3]  # Simulation type

# Construct PCAP filename
pcap_file = "compression_link_{}-3-0.pcap".format(entropy)

# Read PCAP file and filter for RST packets
cap = pyshark.FileCapture(pcap_file, display_filter="tcp.flags.reset == 1")

rst_times = []

# Extract timestamps
for packet in cap:
    timestamp = float(packet.sniff_time.timestamp())
    rst_times.append(timestamp)

    # Stop capturing after finding the first two RST packets
    if len(rst_times) == 2:
        break

cap.close()

# Ensure at least 2 RST packets (ignore extra ones)
if len(rst_times) < 2:
    print(f"❌ Error: Expected at least 2 RST packets, but found {len(rst_times)} in {pcap_file}")
    sys.exit(1)

# Compute ΔT (time difference between first two RST packets)
delta_t = rst_times[1] - rst_times[0]

# Define output file name
output_file = "rst_delay_results_{}.txt".format(simu)

# Write in column format (append mode for multiple runs)
with open(output_file, "a") as f:
    # If file is empty, write header
    if f.tell() == 0:
        f.write("Entropy\t{}\tRST_Delay_Difference(s)\n".format(simu))

    f.write(f"{entropy}\t{packet_number}\t{delta_t:.6f}\n")

print(f"✔ ΔT recorded in {output_file}: {delta_t:.6f} seconds")
