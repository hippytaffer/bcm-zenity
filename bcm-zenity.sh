#!/bin/bash
# bcm device driver finder script by Štefan Uram (the_waiter/bodhilinux)
# with added zenity support by hippytaff

b43 () {
   sudo apt purge bcmwl-kernel-source
   sudo apt install firmware-b43-installer && sudo apt install linux-firmware
}

bcmwl () {
   sudo apt purge firmware-b43-installer
   sudo apt install bcmwl-kernel-source
}

installer () {
   case $1 in
      b43)   b43;;
      bcmwl) bcmwl;;
   esac
}

question () {
 while true; do
     zenity --question --width 200 --text "Do you wish to install\nsuitable bcm driver?"
     if [[ $? = 0 ]]; then
        installer $1;
        break;
     else exit;
     fi
done
}

unknown () {
   zenity --info --width 200 --text 'Unidentified Wifi card.\nPlease check Bodhi wiki!'
}

input=$(lspci -nn -d 14e4:) # executes command and incializes variable
token=$(echo "$input" | awk -F"14e4:" '{print $2}') # find token

var=$(echo "${token// /}")                          # replace spaces
var=$(echo "${var//]/}")                            # replace ]
var=$(echo "${var//(/}")                            # replace (
var=$(echo "${var//)/}")                            # replace )

if [ -z "$token" ]
  then
    zenity --info --width 200 --text "Your Wifi device is not Broadcom!"
    exit 0
else
    zenity --info --width 200 --text "Your Wifi device:\nbcm [14e14:$token"
fi

case $var in
    1713)           question "b43";;
    4301)           question "b43";;
    4306rev02)      question "b43";;
    4306rev03)      question "b43";;
    4307)           question "b43";;
    4311)           question "b43";;
    4311rev01)      question "b43";;
    4312)           question "b43";;
    4313)           question "b43";;
    4315)           question "b43";;
    4315rev01)      question "b43";;
    4318)           question "b43";;
    4318rev02)      question "b43";;
    4319)           question "b43";;
    4320rev02)      question "b43";;
    4320rev03)      question "b43";;
    4321)           question "b43";;
    4324)           question "b43";;
    4325)           question "b43";;
    4328)           question "b43";;
    4328rev03)      question "bcmwl";;
    4329)           question "bcmwl";;
    432a)           question "bcmwl";;
    432b)           question "bcmwl";;
    432c)           question "bcmwl";;
    432d)           question "bcmwl";;
    4331)           question "b43";;
    4335)           question "b43";;
    4350)           question "b43";;
    4353rev01)      question "b43";;
    4358)           question "bcmwl";;
    4359)           question "b43";;
    4360)           question "b43";;
    4365)           question "b43";;
    4365rev01)      question "bcmwl";;
    43a0)           question "bcmwl";;
    43a3)           question "b43";;
    43barev01)      question "b43";;
    43b1)           question "bcmwl";;
    43b1rev03)      question "bcmwl";;
    43c3rev04)      question "b43";;
    4727)           question "bcmwl";;
    a962)           question "b43";;
    *)              unknown;;
esac

