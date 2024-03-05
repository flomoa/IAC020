# Cheat Sheet

## FFUF

| **Task**                    | **Command**                                                                     |
| --------------------------- | ------------------------------------------------------------------------------- |
| Basic fuzzing               | `ffuf -w wordlist.txt -u http://target/FUZZ`                                    |
| Fuzzing with HTTP method    | `ffuf -w wordlist.txt -X POST -d 'data=FUZZ' -u http://target/path`             |
| Fuzzing with headers        | `ffuf -w wordlist.txt -H "Cookie: SESSION=FUZZ" -u http://target`               |
| Recursive fuzzing           | `ffuf -w wordlist.txt -u http://target/FUZZ -recursion`                         |
| Filter by HTTP status       | `ffuf -w wordlist.txt -u http://target/FUZZ -fc 404`                            |
| Match HTTP status           | `ffuf -w wordlist.txt -u http://target/FUZZ -mc 200`                            |
| Output to file              | `ffuf -w wordlist.txt -u http://target/FUZZ -o results.txt`                     |
| Combine multiple wordlists  | `ffuf -w wordlist1.txt:WORDLIST1,wordlist2.txt:WORDLIST2 -u http://target/FUZZ` |
| Limit requests per second   | `ffuf -w wordlist.txt -u http://target/FUZZ -rate 10`                           |
| Filter out specific lengths | `ffuf -w wordlist.txt -u http://target/FUZZ -fl 34`                             |
| Match specific lengths      | `ffuf -w wordlist.txt -u http://target/FUZZ -ml 42`                             |
| Discover directories        | `ffuf -w directories.txt -u http://target/FUZZ`                                 |
| Discover subdomains         | `ffuf -w subdomains.txt -H "Host: FUZZ.target" -u http://target`                |
| Parameter fuzzing           | `ffuf -w parameters.txt -u http://target/path?FUZZ=value`                       |
| Set number of threads       | `ffuf -w wordlist.txt -u http://target/FUZZ -t 50`                              |
| Set request timeout         | `ffuf -w wordlist.txt -u http://target/FUZZ -timeout 10`                        |
## John The Ripper

| Task                     | Command                                                                    |
| ------------------------ | -------------------------------------------------------------------------- |
| Basic password cracking  | `john --wordlist=wordlist.txt passwordfile`                                |
| Single crack mode        | `john --single target_file`                                                |
| Wordlist mode with rules | `john --wordlist=wordlist.txt --rules target_file`                         |
| Incremental mode         | `john --incremental target_file`                                           |
| Show cracked passwords   | `john --show target_file`                                                  |
| Format specification     | `john --format=fmt target_file` (Replace `fmt` with the specific format)   |
| List all formats         | `john --list=formats`                                                      |
| Session management       | `john --session=sessionname target_file`                                   |
| Restore previous session | `john --restore=sessionname`                                               |
| Test performance         | `john --test` (Test the performance of the system)                         |
| External mode use        | `john --external=mode target_file` (Replace `mode` with the specific mode) |
| Crack MD5                | `john --format=raw-md5 --wordlist=rockyou.txt hash1.txt`                   |
| Crack SHA1               | `john --format=raw-sha1 --wordlist=rockyou.txt hash2.txt`                  |
| Mask Attack              | `john –format=hashtype hash.txt –mask?a?a?a?a?a?a?a`                       |
### John mask

| `?1` | lowercase            |
| ---- | -------------------- |
| `?u` | uppercase            |
| `?d` | digits               |
| `?s` | special              |
| `?a` | all                  |
| `?h` | hex                  |
| `?A` | all valid            |
| `?H` | all except null      |
| `?L` | non ASCII lower-case |
| `?U` | non ASCII upper-case |
| `?D` | non ASCII digits     |
| `?S` | non ASCII specials   |
| `?w` | Hybrid               |
