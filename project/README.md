## Sensor
* On button click:
	1. Send message to interface requesting for a worker:
		* No available workers: shed the load
		* Available worker, go to  step 2
	2. Send message to worker with number to be doubled
	3. Loop, sleep and receive:
		* If the timeout is exceeded go back to step 1
		* If an ACK is received go back to idle
- - - -
## Worker
* On a tick send a heartbeat to the interface
* Try to receive message:
	* Do work message:
		1. Double the received number
		2. Sleep for 3 seconds
		3. Send the result to the interface
		4. Send ACK to the sensor
- - - -
## Interface
* Holds the array of all the workers and their state:
	* idle/working
	* number of ticks since last heartbeat
	* address of the worker?
* On every tick increment the ticks of all the workers:
	* If a worker exceeds the maximum number of ticks, remove it from the worker array
* Try to receive message:
	* Display done work:
		1. Display the work
		2. Mark the worker as done
	* Request for idle worker:
		* If there is an idle worker, send the workers address and mark the worker as working
		* If there are no idle workers tell the sensor to shed the load
	* Heartbeat:
		* Set the workers ticks to 0
