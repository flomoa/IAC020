# John the ripper CheatSheet
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

