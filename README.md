# FIO-scripts
Scripts to run FIO tests on storage devices
============

Requirement
-----------

Redhat/Centos,Amazon Linux,Ubuntu and FIO

Description
-----------
This script will run FIO test on the storage device with different Queue Depth and differnet number of jobs for TPC-E, TPC-C and 100% random read/write worklaods. If you want to define Queue depth and number of jobs for your requirement replace the value for i and j where i is Queue depth and j is number of jobs. 

Script Variables
--------------
```
Bloksize 
run time

```
Script Execution Example
--------------

```
For 4k block size test run for 30 Minutes
./randomread-fio.sh 4k 1800

For 8k block size test run for 20 minutes
./randomread-fio.sh 4k 1200
```
Dependencies
------------
 NONE
 
License
-------
 Apache2    
 
Author
-----
vinay reddy @vvinaykumr@gmail.com