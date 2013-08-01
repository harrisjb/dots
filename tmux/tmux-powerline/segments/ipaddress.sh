#! /bin/bash

run_segment() {
ipAddress=$(ifconfig utun0 | grep inet | awk '{print $2}')

echo "${ipAddress}"
}
