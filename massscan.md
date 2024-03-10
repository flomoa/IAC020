# MassScan CheatSheet

# Description
This is an Internet-scale port scanner. It can scan the entire Internet in under 5 minutes, transmitting 10 million packets per second, from a single machine.

# MassScan Examples
## Target specification
```bash
# Target specification
masscan 10.0.0.1 
masscan 10.0.0.0/24 192.168.1.0/24

# Exclude IP file
masscan 10.0.0.1/24 --excludeFile <file>

# Exclude a single IP from the scan
masscan 180.215.0.0/16 --exclude=180.215.122.120
```

## Port specification 
```bash
# Port specification
masscan 10.0.0.0.1 -p 80
masscan 10.0.0.0.1 -p 0-65535
masscan 10.0.0.0.1 -p 80,443

# UDP Scan
masscan 10.0.0.0.1 -pU 53
```

## MassScan
```bash
# Get banners from services (only few protocols supported)
# Problem is that masscan uses his own TCP/IP stack so when the local system 
# received a SYN-ACK from the probed target, it responds with a TST packet that 
# kills the connection before the banner information can be grabbed.
# You can use --source-ip to assign another IP to prevent
masscan 10.0.0.1 --banners

# Assign masscan to another IP
masscan 10.0.0.1 --source-ip 192.168.1.200

# Include a ping
masscan 10.0.0.1 --ping

# Change the default user agent
masscan 10.0.0.1 --http-user-agent <user-agent>

# Report only open ports
masscan 10.0.0.1 --open-only

# Save sent packet in PCAP
masscan 10.0.0.1 --pcap <filename>

# Print packets in terminal (ok in low rate but RIP terminal with high rates)
masscan 10.0.0.1 --packet-trace
```
