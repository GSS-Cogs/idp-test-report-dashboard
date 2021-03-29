
# SIMPLE SERVICE RESTART SCRIPT
# -----------------------------
# Looped in its own process (uses linux screen)
# Check for our target time once per hour
# If it is our target time, kill the running container, wait 2 mins then run the startup script
# Then wait on hour before checking again
# Note1: always waits an hour, regardless of if we got a "hit" on time.
# Note2: the kill command only works because there's ON£ container, be aware
# Note3: you might need "sudo docker...." depending on the box

# 3600   # 1 hour in seconds
sleep_time=120

# 5pm, backend updates at 4pm
target_time=17   

while true
	do
        # if the current hour is equal to the time (in 24 clock) we're waiting for
		if [ $(date "+%H") -eq $target_time ]; then
            
            # Kill the running container
            echo Killing container
            docker kill $(echo * | docker ps | sed -n 2p | cut -d" " -f1)

            # Sleep two minutes to ensure docker has had time to unallocate port
            echo Sleeping for 2 mins to allow for docker port unallocation
            sleep 120
            
            # Start again
            echo calling run at $(date)
        	./run.sh   # initial startup script
        fi
        echo sleepng for: $sleep_time seconds
        sleep $sleep_time
	done