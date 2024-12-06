#!/bin/bash

adress=google.com
interval=1
max_failures=3
threshold_response_ms=100
failure_count=0

while true; do
	result=$(ping -c 1 -w 1 $adress 2>/dev/null)
        
	echo "$result"

	if echo "$result" | grep -q "bytes from"; then 

	   response_time=$(echo $result | grep "time=" | awk -F "time=" '{print $2}' | awk '{print $1}')

	   failure_count=0

	   if (( response_time > threshold_response_ms )); then
		   echo "You have a high ping $response_time ms to $adress"
           else
		   echo "The ping $response_time to $adress is ok"
	   fi
	 else
	     failure_count=$((failure_count + 1))
	     echo "your ping to $adress didn't work ($failure_count/$max_failures)"

	     if (( failure_count >= max_failures )); then
            	echo "i cannot reach  the $adress $max_failures times in a row."
		break
	     fi
	 fi

	 sleep $interval


done


#while true; do
 #       result=$(ping -c 1 -w 1 $address 2>/dev/null)
#
    #    echo "$result"

   #     if echo "$result" | grep -q "bytes from"; then

  #         response_time=$(echo $result | grep "time=" | awk -F "time=" '{print $2}' | awk '{print $1}')

 #          failure_count=0

#           if [[ $response_time -gt $threshold_response_ms ]]; then
  #                 echo "You have a high ping $response_time ms to $adress"
          # else
         #          echo "The ping $response_time to $adress is ok"
        #   fi
       #  else
      #       failure_count=$((failure_count + 1))
     #        echo "your ping to $adress didn't work ($failure_count/$max_failures)"

    #         if [[  $failure_count -ge $max_failures ]]; then
   #             echo "i cannot reach  the $adress $max_failures times in a row."
  #              break
 #            fi
#         fi

 #        sleep $interval


#done

