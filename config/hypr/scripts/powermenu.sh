!#/usr/bin/bash

entries="1) ⏻ power off\n2) ⏼ reboot"
selected=$(echo -e $entries | rofi -dmenu -i -p "Power " -theme-str 'window {width: 350px; height: 350px;}')

case $selected in
	*off) systemctl poweroff ;;
	*reboot) systemctl reboot ;;
esac
