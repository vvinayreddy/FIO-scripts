#!/bin/bash
hn=`hostname`
# i = Queue depth
# j = numjobs
for i in 2 4 6 8 16 32 64 128
do
for j in 2 4 8 16
do
echo Running $i QD with $j JOBS with bs $1 and 100% Sequential Reads
# test 4QD, 2 JOBS and 100 Random read 
sar -u -r -b -d -n DEV 5 240 >> sar_$1_100SR_"$i"QD_"$j"Jobs_$hn.log &

iostat -x 5 240 >> iostat_$1_100SR_"$i"QD_"$j"Jobs_$hn.log &

top -b -d 5 >> top_$1_100SR_"$i"QD_"$j"Jobs_$hn.log &

/usr/bin/fio --name=sequentialReadTest --rw=read --rwmixwrite=0 --bs=$1 --invalidate=1 --direct=1 --filename=/dev/sdb:/dev/sdc  --group_reporting --time_based --runtime=$2 --ioengine=libaio --numjobs=$j --iodepth=$i --norandommap --randrepeat=0 --exitall --output-format=json --output=fiotest_$1_100SR_"$i"QD_"$j"Jobs_$hn.json
pkill top 
pkill sar
pkill iostat
echo Running $i QD with $j JOBS with bs $1 and 100% Sequential Writes
# test 4QD, 2 JOBS and 70% Read and 30% write

sar -u -r -b -d -n DEV 5 240 >> sar_$1_100SW_"$i"QD_"$j"Jobs_$hn.log &

iostat -x 5 240 >> iostat_$1_100SW_"$i"QD_"$j"Jobs_$hn.log &

top -b -d 5 >> top_$1_100SW_"$i"QD_"$j"Jobs_$hn.log &

/usr/bin/fio --name=sequentialWriteTest --rw=write --rwmixread=0 --bs=$1 --invalidate=1 --direct=1 --filename=/dev/sdb:/dev/sdc  --group_reporting --time_based --runtime=$2 --ioengine=libaio --numjobs=$j --iodepth=$i --norandommap --randrepeat=0 --exitall --output-format=json --output=fiotest_$1_100SW_"$i"QD_"$j"Jobs_$hn.json
pkill top 
pkill sar
pkill iostat
done;
done;
