#!/bin/bash


if [[ ! -e /home/nathan/FeedFetcherDeluxe/feedfetcher.pid ]] ; then
	echo "Restarting feedfetcher because pid file wasn't found"
	`cd /home/nathan/FeedFetcherDeluxe/perl; perl Feedfetcher/ff.pl `
else
	echo "File existed, checking pid"
	pid=`cat /home/nathan/FeedFetcherDeluxe/feedfetcher.pid`

	for i in $pid; do
	        `kill -0 $i`
	        if [ $? != 0 ]; then
			echo "Restarting feedfetcher because no process was found"
        	        `cd /home/nathan/FeedFetcherDeluxe/perl; perl Feedfetcher/ff.pl `
	        else
        	        echo "Feedfetcher process found! Do nothing."
	        fi
	done
fi

