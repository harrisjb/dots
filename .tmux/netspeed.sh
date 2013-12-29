#!/usr/bin/env bash
#              bash 4.1.5(1)     Linux Ubuntu 10.04               Date : 2011-10-09
#
# _______________|  netspeed : check download speed via command line.
#
#           Usage:  netspeed [tokyo, london, usw, use, east, west, URL]
#                                            ^default U.S. west coast.
#                            [ -speed_KB/sec ]
#                              ^negation activates the Mbps converter.
#
#                            First try it out without any arguments.
#                                            
#    Dependencies:  wget 
#                   (rate displayed in Kilobytes per second, 
#                    whereas speed tests usually adopt Megabits.)
#
#   Example units:  Download Speed: 659 kbps     (82.4 KB/sec transfer rate)
#                     Upload Speed: 317 kbps     (39.6 KB/sec transfer rate)
#                                       kb=kilobits    KB=Kilobytes
#                   So  0.007813 Mb =    8 kilobits =   1 Kilobyte
#                   since      1 Mb = 1024 kilobits = 128 Kilobytes
#
#           Units:  b stands for bit and B stands for byte. In the context of 
#                   data rate units, one byte refers to 8 bits. For example, 
#                   when a 1 Mbps connection is advertised, it usually means 
#                   that the maximum achievable download bandwidth is 
#                   1  megabit/s (million bits per second), which is actually 
#                   0.125   MB/s (megabyte per second), or about 
#                   0.1192 MiB/s (mebibyte per second). 
#                   http://en.wikipedia.org/wiki/Mbit/s#megabit_per_second


#  CHANGE LOG  get LATEST version from https://bitbucket.org/rsvp/gists/src
#
#  2011-10-09  Add rate conversion to Mbps using negated first argument.
#  2011-10-08  Add URL as possible arg. Clarify rate units.
#                 Public as gist to https://gist.github.com/1272488
#  2011-10-07  First version based on wget, though curl also works:
#                 http://stackoverflow.com/questions/426272
#                 Command line alternative to http://www.speedtest.net

#           _____ Prelims
set -u
#   ^ unbound (i.e. unassigned) variables shall be errors.
set -e
#   ^ error checking :: Highly Recommended (caveat:  you can't check $? later).  
#
# _______________     ::  BEGIN  Script ::::::::::::::::::::::::::::::::::::::::

site=${1:-'usw'}


case $site in 
     'london') test='http://london1.linode.com/100MB-london.bin'    ;;
     'tokyo')  test='http://tokyo1.linode.com/100MB-tokyo.bin'      ;;
     'usw')    test='http://fremont1.linode.com/100MB-fremont.bin'  ;;
               #  US West:  Fremont, California
     'use')    test='http://newark1.linode.com/100MB-newark.bin'    ;;
               #  US East:  Newark, New Jersey
     'east')   test='http://speedtest.wdc01.softlayer.com/downloads/test500.zip'                 ;;
               #  US East:  Washington, D.C.
     'west')   test='http://speedtest.sjc01.softlayer.com/speedtest/speedtest/random500x500.jpg' ;;
               #  US West:  San Jose, California
     *)        test=$1  ;;
               #  valid URL assumed, else wget will give any error message.
esac
     #  Sources:
     #  2011-10-07  http://www.linode.com/speedtest/      for file URL.
     #              http://speedtest.wdc01.softlayer.com  for actual testing.



if [ $test = -${test#-} ] ; then
     #     ^check for negative sign in the first argument.
     echo "`awk "END { print ($test * -0.007813) }" /dev/null` Mbps"
     #      awk as nice floating-point calculator!
else
     echo ' ::  Rate in Kilobytes/sec; industry usually adopts megabits/sec:       '
     echo ' ::        1 Kilobytes/sec (K/s)   =       0.007813 megabits/sec (Mbps).'
     echo ' ::        To convert, use negated rate as first argument to netspeed.  '
     echo ' ::  [Terminate netspeed by control-C]     [ cf. http://speedtest.net ] '
     echo ' ::  '
     #      MAIN
     wget  --output-document=/dev/null  $test 
fi

#       If --output-file for wget was used to log results...
#
#  --2011-10-07 21:38:27--  
#  Resolving speedtest.sjc01.softlayer.com... 50.23.64.58
#  Connecting to speedtest.sjc01.softlayer.com|50.23.64.58|:80... connected.
#  HTTP request sent, awaiting response... 200 OK
#  Length: 505544 (494K) [image/jpeg]
#  Saving to: `/dev/null'
#  
#       0K .......... .......... .......... .......... .......... 10% 80.9K 5s
#      50K .......... .......... .......... .......... .......... 20% 78.5K 5s
#     100K .......... .......... .......... .......... .......... 30% 80.8K 4s
#     150K .......... .......... .......... .......... .......... 40% 78.8K 4s
#     200K .......... .......... .......... .......... .......... 50% 80.8K 3s
#     250K .......... .......... .......... .......... .......... 60% 78.5K 2s
#     300K .......... .......... .......... .......... .......... 70% 78.8K 2s
#     350K .......... .......... .......... .......... .......... 81% 80.8K 1s
#     400K .......... .......... .......... .......... .......... 91% 78.5K 1s
#     450K .......... .......... .......... .......... ...       100% 81.9K=6.2s
#  
#  2011-10-07 21:38:33 (79.8 KB/s) - `/dev/null' saved [505544/505544]


exit 0
# _______________ EOS ::  END of Script ::::::::::::::::::::::::::::::::::::::::


#  #  Alternative to wget...
#  curl -o /dev/null  $test
#  #  curl is less verbose than wget. Speed is displayed as bytes per second:
#  #
#  #    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#  #                                   Dload  Upload   Total   Spent    Left  Speed
#  #    0  500M    0 4931k    0     0  80993      0  1:47:53  0:01:02  1:46:51 81520

