#!/bin/sh

# Get class of a wid
get_class() {
	id=$1
  if [ -z "$id" ]; then
    echo ""
  else
	  xprop -id "$id" | sed -n '/WM_CLASS\|WM_COMMAND/s/.*"\(.*\)".*/\1/p'
  fi
}

swallow() {
	addedtodesktop=$2
	lasttermdesktop=$(bspc query -D -n last)

	swallowerid=$1
	swallowingid=$(bspc query -N -n last)

	if [ "$addedtodesktop" = "$lasttermdesktop" ]; then
		cat ~/.config/bspwm/noswallow ~/.config/bspwm/terminals | grep "^$(get_class "$swallowerid")$" && return
		grep "^$(get_class "$swallowingid")$" ~/.config/bspwm/terminals || return
		echo "$swallowerid $swallowingid" >> /tmp/swallowids
		bspc node "$swallowingid" --flag hidden=on
	fi
}

spit() {
	spitterid=$1
	spitterdesktop=$2
	grep "^$spitterid" /tmp/swallowids || return
	spittingid=$(grep "^$spitterid" /tmp/swallowids | head -n1 | awk '{print $2}')

	bspc node "$spittingid" --flag hidden=off

	termdesktop=$(bspc query -D -n "$spittingid")
	[ "$termdesktop" = "$spitterdesktop" ] || bspc node "$spittingid" -d "$spitterdesktop"

	bspc node "$spittingid" -f
	sed -i "/^$spitterid/d" /tmp/swallowids
}

bspc subscribe node_add node_remove | while read -r event
do
	case $(echo "$event" | awk '{ print $1 }') in
		node_add)
            		swallow $(echo "$event" | awk '{print $5 " " $3}')
			;;
		node_remove)
			spit $(echo "$event" | awk '{print $4 " " $3}')
			;;
	esac
done
