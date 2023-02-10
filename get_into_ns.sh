#!/bin/bash

ROOT="$(dirname "$0")"
source $ROOT/sources/extra.sh


none="0m"

#for colorizing ns BASH prompt
declare -A ns_colors
ns_colors=(
  [0]="31m" #red
  [1]="32m" #green
  [2]="33m" #yellow
  [3]="34m" #blue
  [4]="35m" #purple
  [5]="36m" #cyan
  [6]="93m" 
  [7]="95m"
)


function show_help 
 { 
 	c_print "None" "This scripts gets you into a networking namespace BASH with a colorized promt that helps you easily identify (later) where you are at."
 	c_print "Bold" "Example: ./get_into_ns.sh -n NAMESPACE\n"
 	exit
 }

NS=""
while getopts "h?n:" opt
do
  case "$opt" in
      h|\?)
        show_help
        ;;
      n)
        NS=$OPTARG
        ;;
      *)
        show_help
        ;;
  esac
done

if [ -z $NS ]
then
  c_print "Red" "No namespace name provided!"
  show_help
fi


c_print "Green" "Getting into namespace ${NS}..."

num_colors=${#ns_colors[@]}
rnd=$(echo $((0 + RANDOM % $num_colors)))
c=${ns_colors[${rnd}]}

bash_file=$ROOT/sources/ns_bashrc
cat $bash_file | sed "s/<NS>/${NS}/" |sed "s/<COLOR>/$c/" > $ROOT/tmp_${NS}.bashrc
sudo ip netns exec $NS bash --rcfile $ROOT/tmp_${NS}.bashrc

retval=$?
check_retval $retval



