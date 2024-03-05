# Hashcat Attack mode
| Command | Action                 |
| ------- | ---------------------- |
| -a 0    | Straight               |
| -a 1    | Combination            |
| -a 3    | Bruteforce             |
| -a 6    | Hybrid wordlist + mask |
| -a 7    | Hybrid mask + wordlist |

# Hashcat charsets
| Command | Action                    |
| ------- | ------------------------- |
| ?l      | a-z Lowercase             |
| ?u      | A-Z Uppercase             |
| ?d      | Decimals                  |
| ?h      | Hex using lowercase chars |
| ?H      | Hex using uppercase chars |
| ?s      | Special chars             |
| ?a      | All (l, u, d, s)          |
| ?b      | Binary                    |

# Hashcat options
| Command           | Action                                  |
| ----------------- | --------------------------------------- |
| -m                | Hash type                               |
| -a                | Attack mode                             |
| -r                | Rules                                   |
| -V                | Version                                 |
| --status          | Keep screen updated                     |
| -b                | Benchmark                               |
| --runtime         | Abort after X seconds                   |
| --session [name]  | Set session name                        |
| --restore         | Restore/Resume Session                  |
| -o                | Output file                             |
| --username        | Ignore username field in hash           |
| --potfile-disable | Ignore Potfile                          |
| --potfile-path    | Set Potfile path                        |
| -d                | Specify OpenCL device                   |
| -D                | Specify OpenCL device type              |
| -l                | List OpenCL devices & types             |
| -O                | Optimized kernel for password more than |
| -i                | Increment                               |
| --increment-min   | Start increment at X chars              |
| --increment-max   | Stop increment at X chars               |
|                   |                                         |
# Commands Examples

```shell
# Benchmark MD4 hashes
hashcat -b -m 900

# Create a hashcat session to hash Kerberos 5 tickets using wordlist
hashcat -m 13100 -a 0 --session crackin1 hashes.txt wordlist.txt -o output.pot

# Crack MD5 hashes using all char in 7 char passwords
hashcat -m 0 -a 3 -i hashes.txt ?a?a?a?a?a?a?a -o output.pot

# Crack SHA1 by using wordlist with 2 char at the end 
hashcat -m 100 -a 6 hashes.txt wordlist.txt ?a?a -o output.pot

# Crack WinZip hash using mask (Summer2018!)
hashcat -m 13600 -a 3 hashes.txt ?u?l?l?l?l?l?l?d?d?d?d! -o output.pot

# Crack MD5 hashes using dictionnary and rules
hashcat -a 0 -m 0 example0.hash example.dict -r rules/best64.rules

# Crack MD5 using combinator function with 2 dictionnaries
hashcat -a 1 -m 0 example0.hash example.dict example.dict

# Cracking NTLM hashes
hashcat64 -m 1000 -a 0 -w 4 --force --opencl-device-types 1,2 -O d:\hashsample.hash "d:\WORDLISTS\realuniq.lst" -r OneRuleToRuleThemAll.rule

# Cracking hashes from kerberoasting
hashcat64 -m 13100 -a 0 -w 4 --force --opencl-device-types 1,2 -O d:\krb5tgs.hash d:\WORDLISTS\realhuman_phill.txt -r OneRuleToRuleThemAll.rule
```

# Scénario

```shell
# Start by making a specific potfile and cracked files (clean environment)
# - domain_ntds.dit
# - domain_ntds_potfile.pot

# Goal is to run many different instances with different settings, so each one have
# to be quite quick

# You can generate wordlist using CeWL
# It usually works pretty well
cewl -d 5 -m 4 -w OUTFILE -v URL
cewl -d 5 -m 4 -w OUTFILE -o -v URL

# With some basic dictionnary cracking (use known wordlists)
# rockyou, hibp, crackstation, richelieu, kaonashi, french and english 
.\hashcat64.exe -m 1000 hashs.txt --potfile-path potfile.pot -a 0 rockyou.txt --force -O

# Then start to use wordlists + masks + simple rule
# For special chars, you can use a custom charset : "?!%$&#-_@+=* "
# Multiple tests, multiples masks and multiples wordlists (including generated ones)
.\hashcat64.exe -m 1000 hashs.txt -a 6 .\french\* '?d?d?d?d' -j c --increment --force -O
.\hashcat64.exe -m 1000 hashs.txt -a 6 .\french\* -1 .\charsets\custom.chr '?1' -j c --force -O
.\hashcat64.exe -m 1000 hashs.txt -a 6 .\french\* -1 .\charsets\custom.chr '?d?1' -j c --force -O
.\hashcat64.exe -m 1000 hashs.txt -a 6 .\french\* -1 .\charsets\custom.chr '?d?d?1' -j c --force -O
.\hashcat64.exe -m 1000 hashs.txt -a 6 .\french\* -1 .\charsets\custom.chr '?d?d?d?1' -j c --force -O
.\hashcat64.exe -m 1000 hashs.txt -a 6 .\french\* -1 .\charsets\custom.chr '?d?d?d?d?1' -j c --force -O
.\hashcat64.exe -m 1000 hashs.txt -a 6 CEWL_WORDLIST.txt -1 .\charsets\custom.chr '?d?d?d?d?1' -j c --force -O
.\hashcat64.exe ...

# Same commands and behavior but using mask after the tested word (mode 7)
.\hashcat64.exe -m 1000 hashs.txt -a 7 '?d?d?d?d' .\french\* -j c --increment --force -O

# Then, wordlists + complex rules
# Once again run against multiple wordlists (including generated ones)
# Kaonashi and OneRuleToRuleThemAll can produce maaaaaassive cracking time
.\hashcat64.exe -m 1000 hashs.txt --potfile-path potfile.pot -a 0 french.txt -r .rules\best64.rule --force -O
.\hashcat64.exe -m 1000 hashs.txt --potfile-path potfile.pot -a 0 french.txt -r .rules\OneRuleToRuleThemAll.rule --force -O
.\hashcat64.exe -m 1000 hashs.txt --potfile-path potfile.pot -a 0 french.txt -r .rules\best64.rule --force -O
.\hashcat64.exe ...

# Then smart bruteforce using masks (custom charset can be usefull too)
# Can be quite long, depending on the mask. Many little tests with different masks
# Knowing for example that password is min 8 char long, only 8+ masks
# Play by incrementing or decrementing char vs decimal (you can also use specific charset to reduce time)
.\hashcat -m 1000 hashs.txt --potfile-path potfile.pot -a 3 '?u?l?l?l?d?d?d?d' --force -O
.\hashcat -m 1000 hashs.txt --potfile-path potfile.pot -a 3 '?u?l?l?l?l?d?d?d' --force -O
.\hashcat -m 1000 hashs.txt --potfile-path potfile.pot -a 3 '?u?l?l?l?l?l?d?d' --force -O
.\hashcat -m 1000 hashs.txt --potfile-path potfile.pot -a 3 -1 .\charset\custom '?u?l?l?l?l?l?d?1' --force -O
.\hashcat ...

# Then increment mask size and play again
# Can be longer for 9 char and above.. Up to you to decide which masks and how long you wanna wait
.\hashcat -m 1000 hashs.txt --potfile-path potfile.pot -a 3 '?u?l?l?l?d?d?d?d?d' --force -O
.\hashcat -m 1000 hashs.txt --potfile-path potfile.pot -a 3 '?u?l?l?l?l?d?d?d?d' --force -O
.\hashcat -m 1000 hashs.txt --potfile-path potfile.pot -a 3 '?u?l?l?l?l?l?d?d?d' --force -O
.\hashcat64.exe ...

# If you have few hashes and small/medium wordlist, you can use random rules
# And make several loops
.\hashcat64.exe -m 1000 hashs.txt --potfile-path potfile.pot -a 0 wl.txt -g 1000000  --force -O -w 3

# You can use combination attacks
# For example, combine different names, or combine names with dates.. Then apply masks
# Directly using hashcat
.\hashcat64.exe -m 1000 hashs.txt --potfile-path potfile.pot -a 1 wordlist1.txt wordlist2.txt --force -O
# Or in memory feeding, it allows you to use rules but not masks
.\combinator.exe wordlist1.txt wordlist2.txt | .\hashcat64.exe -m 1000 hashs.txt --potfile-path potfile.pot -a 0 -rules .\rules\best64.rule --force -O
# Or create the wordlist before and use it
.\combinator.exe wordlist1.txt wordlist2.txt
.\hashcat64.exe -m 1000 hashs.txt --potfile-path potfile.pot -a 6 combinedwordlist.txt '?d?d?d?d' -j c --increment --force -O

# Finally use your already cracked passwords to build a new wordlist
.\hashcat64.exe -m 1000 hashs.txt --potfile-path potfile.pot --show | %{$_.split(':')[1]} > cracked.txt
.\hashcat64.exe -m 1000 hashs.txt -a 6 cracked.txt '?d?d?d?d' -j c --increment --force -O
.\hashcat64.exe -m 1000 hashs.txt -a 0 cracked.txt -r .rules\OneRuleToRuleThemAll.rule --force -O
```
