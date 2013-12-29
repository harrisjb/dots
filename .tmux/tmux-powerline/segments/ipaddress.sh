#! /bin/bash

run_segment() {
ipAddress=$(ifconfig utun0 | grep inet | awk '{print $2}')
if [[ ! $ipAddress ]]; then
  echo "ⓛ  No VPN connection!"
else
  echo "ⓛ ${ipAddress}"
fi
}
