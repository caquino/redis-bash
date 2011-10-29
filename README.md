# REDIS-BASH - Bash library to access Redis Databases
* The library comes with two examples, one generic client and a pubsub demo.
* This library has no external dependencies, using only bash built-in commands.
* The only requirement is bash to have net redirections enabled.

## Using the client and the pubsub demo
redis-bash-cli \<PARAMETERS\> \<COMMAND\> \<ARGUMENTS\>

Parameters:
* -h Host - Defaults localhost.
* -p Port - Defaults 6379.
* -n DB - Select the database DB.
* -r N - Repeat command N times.
	

redis-pubsub-test \<CHANNEL\>
	The redis host and port is hardcoded in the script, change the script if you need.
	
Testing
-------
In one shell run the command:

redis-pubsub-test test

In another shell run the command:

redis-bash-cli -h localhost -p 6379 PUBLISH test "Hello World."
	
Using the Library
=================
The library have a single function to handle the redis communication.

redis-client \<fd\> \<command\>

fd: file descriptor to access the redis database
command: command to be sent to the server, can be blank to do read operation.

Using the library:

	#!/bin/bash
	source redis-bash-lib # include the library itself
	exec 6<>/dev/tcp/localhost/6379 # open the connection to the redis server
	redis-client 6 SET test 1234 # do a SET operation in the redis on the file descriptor 6
	exec 6>&- #close fd`


TODO
====
- manual page
- tests

LICENSE
=======
BSD

THANKS
======
- Andre Ferraz - Debian Package
