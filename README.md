## Network Host Discovery Tool: Pingy

**Pingy** is a convenient tool designed to discover active hosts in your local network and subsequently perform a quick port scan on each of these hosts using `nmap`.

### Installation and Setup

1. **Download the Script**
   
   To get the script, either clone the repository or directly download the script file.
   ```
   git clone [YOUR_REPOSITORY_LINK_HERE]
   ```
   Or, if you prefer a direct download:
   ```
   wget [YOUR_DIRECT_DOWNLOAD_LINK_HERE]/pingy.sh
   ```

2. **Provide Execution Permissions**
   
   After downloading, give the script the necessary execution permissions. Navigate to the directory containing `pingy.sh` and execute:
   ```
   chmod +x pingy.sh
   ```

### Usage

To initiate the script, simply run:
```
./pingy.sh
```
Upon execution, the script will:
1. Extract the first three octets of your IP address.
2. Ping all potential hosts in your subnet (presuming a /24 network).
3. Save the active hosts' IP addresses to a sorted file named `SORTED_[YOUR_OCTETS].txt`.
4. Conduct a quick port scan on each detected host using `nmap`.

### Output

Throughout its operation, **Pingy** offers real-time feedback:
1. It discloses the extracted octets from your IP.
2. It displays which hosts within the subnet are active.
3. It presents a list of open ports and the respective services for every detected host.
