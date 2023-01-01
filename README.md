# REDIS-BASH - Bash library to access Redis Databases

[![Release](https://github.com/caquino/redis-bash/actions/workflows/release.yml/badge.svg)](https://github.com/caquino/redis-bash/actions/workflows/release.yml)
* The library comes with two examples, one generic client and a pubsub demo.
* This library has no external dependencies, using only bash built-in commands.
* The only requirement is bash to have net redirections enabled.
* The command validation is made by the server.

## Using the client and the pubsub demo

### Client
```bash
$ redis-bash-cli <PARAMETERS> <COMMAND> <ARGUMENTS>
```

Parameters:

```
-h Host - Defaults localhost.
-p Port - Defaults 6379.
-n DB - Select the database DB.
-r N - Repeat command N times.
-a PASSWORD - Authentication password
   OR -a "USERNAME PASSWORD" - Authentication username & password in double quotes
-i INTERVAL - Interval between commands
```

Examples:

```bash
$ redis-bash-cli -h localhost SET testkey 1234
OK

$ redis-bash-cli -h localhost GET testkey
1234

$ redis-bash-cli -h localhost PING
PONG

$ redis-bash-cli -h localhost -r 5 PING
PONG
PONG
PONG
PONG
PONG

$ redis-bash-cli -h localhost WRONGCOMMAND test
ERR unknown command 'WRONGCOMMAND'
```

Authenticated requests:

```bash
$ redis-bash-cli -h localhost PING
ERR operation not permitted

$ redis-bash-cli -h localhost -a test PING
PONG
```

### Pubsub

```bash
$ redis-pubsub-test <PARAMETERS> <CHANNEL>
```

Parameters:

```bash
-h Host - Defaults localhost.
-p Port - Defaults 6379.
CHANNEL - Channel to subscribe
```

## Pubsub demo
In one shell run the command:

```bash
$ redis-pubsub-test test
```

In another shell run the command:

```bash
$ redis-bash-cli -h localhost -p 6379 PUBLISH test "Hello World."
```

# Using the Library in your code
The library have a single function to handle the redis communication.

```bash
$ redis-client <FD> <COMMAND>
```

* FD: file descriptor to access the redis database
* COMMAND: command to be sent to the server, can be blank to do read operation.

Using the library:

```bash
#!/bin/bash
source redis-bash-lib # include the library
exec 6<>/dev/tcp/localhost/6379 # open the connection
redis-client 6 SET test 1234 # do a SET operation
exec 6>&- # close the connection
```

# TODO
* manual page
* tests
* documentation

# LICENSE
* BSD

# Debian Package
* To build the debian/ubuntu package use dpkg-buildpackage.

# CONTACT
* email: cassianoaquino at me.com
* twitter: @syshero
* blog: http://syshero.org/

# THANKS
* Andre Ferraz - Debian Package
* Juliano Martinez - Idea to handle socket disconnections on the pubsub demo

# TESTED
* Debian squeeze 6.0.X - GNU bash, version 4.1.5(1)-release (x86_64-pc-linux-gnu)
* Mac OS X Lion 10.7.X - GNU bash, version 3.2.48(1)-release (x86_64-apple-darwin11)

# PERFORMANCE

This test has no intent to be a complete benchmark, but only to show the diference between both clients.


```bash
$ time redis-bash-cli -h 192.168.86.1 -r 10 PING > /dev/null

real0m0.027s
user0m0.000s
sys0m0.024s

$ time redis-cli -h 192.168.86.1 -r 10 PING > /dev/null

real0m0.012s
user0m0.000s
sys0m0.008s
```
