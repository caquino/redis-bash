# REDIS-BASH - Bash library to access Redis Databases
* The library comes with two examples, one generic client and a pubsub demo.
* This library has no external dependencies, using only bash built-in commands.
* The only requirement is bash to have net redirections enabled.
* The command validation is made by the server.

## Using the client and the pubsub demo

### Client
	redis-bash-cli <PARAMETERS> <COMMAND> <ARGUMENTS>

Parameters:

	-h Host - Defaults localhost.
	-p Port - Defaults 6379.
	-n DB - Select the database DB.
	-r N - Repeat command N times.
	
Examples:

	redis-bash-cli -h localhost SET testkey 1234
	OK
	
	redis-bash-cli -h localhost GET testkey
	1234
	
	redis-bash-cli -h localhost PING
	PONG
	
	redis-bash-cli -h localhost -r 5 PING
	PONG
	PONG
	PONG
	PONG
	PONG
	
	redis-bash-cli -h localhost WRONGCOMMAND test
	ERR unknown command 'WRONGCOMMAND'

### Pubsub

	redis-pubsub-test <PARAMETERS> <CHANNEL>
	
Parameters:

	-h Host - Defaults localhost.
	-p Port - Defaults 6379.
	CHANNEL - Channel to subscribe
		
## Pubsub demo
In one shell run the command:

	redis-pubsub-test test

In another shell run the command:

	redis-bash-cli -h localhost -p 6379 PUBLISH test "Hello World."
	
# Using the Library in your code
The library have a single function to handle the redis communication.

	redis-client <FD> <COMMAND>

* FD: file descriptor to access the redis database
* COMMAND: command to be sent to the server, can be blank to do read operation.

Using the library:

	#!/bin/bash
	source redis-bash-lib # include the library
	exec 6<>/dev/tcp/localhost/6379 # open the connection
	redis-client 6 SET test 1234 # do a SET operation
	exec 6>&- # close the connection


# TODO
* manual page
* tests
* documentation

# LICENSE
* BSD

# Debian Package
* To build the debian/ubuntu package use dpkg-buildpackage.

# THANKS
* Andre Ferraz - Debian Package
* Juliano Martinez - Idea to handle socket disconnections on the pubsub demo

# TESTED
* Debian squeeze 6.0.3
- GNU bash, version 4.1.5(1)-release (x86_64-pc-linux-gnu)
* Mac OS X Lion 10.7.2
- GNU bash, version 3.2.48(1)-release (x86_64-apple-darwin11)

# PERFORMANCE

This test has no intent to be a complete benchmark, but only to show the diference between both clients.


    time redis-bash-cli -h 192.168.86.1 -r 10 PING > /dev/null

    real0m0.027s
    user0m0.000s
    sys0m0.024s

    time redis-cli -h 192.168.86.1 -r 10 PING > /dev/null

    real0m0.012s
    user0m0.000s
    sys0m0.008s
