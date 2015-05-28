# CDH 5.1.0 pseudo-distributed cluster Docker image for Debian Wheezy

This is a fork of [Chalis pseudo distributed cluster docker image](https://github.com/chali/cdh5-pseudo-distributed-cluster-docker) 

######Changes
* Wheezy as a base image
* install necessary packages
* install Obstacle Java with automatic accepting the license
* install the Cloudera repository with the very version for the GXL project and the Cloudera key 
* install pig

The way of running services looks not optimal, but has not been changed


The services installed are

#####Installed services
* HDFS
* YARN
* JobHistoryServer
* Oozie
* PIG

The

###Build the docker image

*Warning the build process downloads more than 1.5 GB of data.* A smaller and fully installed image can be distributed.

This can  be very slooooow in the office

Get docker image

    docker build .

Run image with specified port mapping

    docker run --name cdh -d -p 8020:8020 -p 50070:50070 -p 50010:50010 -p 50020:50020 -p 50075:50075 -p 8030:8030 -p 8031:8031 -p 8032:8032 -p 8033:8033 -p 8088:8088 -p 8040:8040 -p 8042:8042 -p 10020:10020 -p 19888:19888 -p 11000:11000 <image id from the build process>

 Or you can use docker-compose configuration from [here](https://github.com/chali/cdh5-pseudo-distributed-cluster-docker-compose)

Further tests on these base image can be done by joining the container with

    docker exec -t -i <container id from the run command> /bin/bash
    
This requires a recent docker version, see the [Docker cli reference](https://docs.docker.com/reference/commandline/cli)
 
If you are Mac OS user with boot2docker and you would like to get from your local system to a cdh container add these port forwardings

	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8020,tcp,,8020,,8020"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port50070,tcp,,50070,,50070"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port50010,tcp,,50010,,50010"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port50020,tcp,,50020,,50020"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port50075,tcp,,50075,,50075"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8030,tcp,,8030,,8030"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8031,tcp,,8031,,8031"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8032,tcp,,8032,,8032"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8033,tcp,,8033,,8033"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8088,tcp,,8088,,8088"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8040,tcp,,8040,,8040"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8042,tcp,,8042,,8042"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port10020,tcp,,10020,,10020"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port19888,tcp,,19888,,19888"
	VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port11000,tcp,,11000,,11000"
