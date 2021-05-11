#!/bin/sh

(
echo "Log Started: `date`"
echo "User: `users`"
echo " "

echo "==========================================="
echo "================Distro Info================"
echo "==========================================="
cat /etc/*-release
echo " "

echo "==========================================="
echo "===jack_control status - Is JACK Running?=="
echo "==========================================="
jack_control status
echo " "

echo "==========================================="
echo "====pactl stat - Is PulseAudio Running?===="
echo "==========================================="
pactl stat
echo " "

echo "==========================================="
echo "=====pacmd list-sinks - Print Outputs======"
echo "==========================================="
case "${1:-}" in
  (""|list)
    pacmd list-sinks |
      grep -E 'available.|index:|name:|properties:|jack.client_name|alsa.card_name|device.product.name'
    ;;
esac
echo " "

echo "==========================================="
echo "=====pacmd list-sources - Print Inputs====="
echo "==========================================="
case "${1:-}" in
  (""|list)
    pacmd list-sources |
      grep -E 'available.|index:|name:|properties:|jack.client_name|alsa.card_name|device.product.name'
    ;;
esac
echo " "

echo "==========================================="
echo "======Stopping Jack for error catching====="
echo "==========================================="
jack_control stop
jack_control exit
echo " "

echo "==========================================="
echo "=Restarting PulseAudio for error catching=="
echo "==========================================="
pulseaudio --kill
pactl stat
echo " "

echo "==========================================="
echo "=====Starting GoXLR for error catching====="
echo "==========================================="
sh /etc/goxlr/goxlr-on-linux/configure_goxlr.sh
echo " "

echo "==========================================="
echo "====Is JACK Running? -- After Restarting==="
echo "==========================================="
jack_control status
echo " "

echo "==========================================="
echo "=Is PulseAudio Running? -- After Restarting"
echo "==========================================="
pactl stat
echo " "

echo "==========================================="
echo "=====Print Outputs -- After Restarting====="
echo "==========================================="
case "${1:-}" in
  (""|list)
    pacmd list-sinks |
      grep -E 'available.|index:|name:|properties:|jack.client_name|alsa.card_name|device.product.name'
    ;;
esac
echo " "

echo "==========================================="
echo "======Print Inputs -- After Restarting====="
echo "==========================================="
case "${1:-}" in
  (""|list)
    pacmd list-sources |
      grep -E 'available.|index:|name:|properties:|jack.client_name|alsa.card_name|device.product.name'
    ;;
esac
echo " "

echo "Log Finished: `date`"
) 2>&1 | sudo tee $Home/GoXLR_Log.txt

read ""
