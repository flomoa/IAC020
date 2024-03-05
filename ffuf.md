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

