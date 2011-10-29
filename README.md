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
	
* The redis host and port is hardcoded in the script, change the script if you need.
	
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
	source redis-bash-lib # include the library itself
	exec 6<>/dev/tcp/localhost/6379 # open the connection to the redis server
	redis-client 6 SET test 1234 # do a SET operation in the redis on the file descriptor 6
	exec 6>&- #close fd`


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