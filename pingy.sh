#!/bin/bash

# Define colors for better UX
GREEN="\033[1;32m"
BLUE="\033[1;34m"
RESET="\033[0m"
SEPARATOR="-------------------------------------------------"

# Get the first octets of the network ip
OCTETS=$(ip -o -f inet addr show | awk '/scope global/ {print $4}' | cut -d '/' -f 1 | cut -d "." -f 1,2,3 | head -n 1)

# Display the extracted octets for debugging
echo -e "${BLUE}${SEPARATOR}\nExtracted Octets: $OCTETS\n${SEPARATOR}${RESET}"

# Check if the extracted OCTETS are valid
if [ -z "$OCTETS" ]; then
    echo "Failed to extract the network octets. Exiting."
    exit 1
fi

# File to store live hosts
OUTPUT_FILE="SORTED_$OCTETS.txt"

# Clear or create the output file
> "$OUTPUT_FILE"

# Display the current activity
echo -e "${GREEN}Pinging hosts in the subnet...${RESET}"

# Loop through the subnet, excluding .0 and .255 (assuming a /24 subnet)
for ip in {1..254}
do
    {
        # Check if it's potentially a broadcast or network address
        if [ "$ip" -ne 0 ] && [ "$ip" -ne 255 ]; then
            if ping -c 1 "$OCTETS.$ip" | grep "64 bytes"; then
                echo -e "${GREEN}$OCTETS.$ip is alive.${RESET}"
                echo "$OCTETS.$ip" >> "$OUTPUT_FILE"
            fi
        fi
    } &
done

# Wait for all background pings to complete
wait

# Sort the results in-place
echo -e "\n${BLUE}${SEPARATOR}\nSorting the results...\n${SEPARATOR}${RESET}"

sort -o "$OUTPUT_FILE" "$OUTPUT_FILE"

# Display the current activity
echo -e "${GREEN}Running nmap scan on found hosts...\n${SEPARATOR}${RESET}"

# Perform scan by nmap
nmap -sS -iL "$OUTPUT_FILE"

exit

