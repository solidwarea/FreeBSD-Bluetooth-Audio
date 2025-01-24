BD_ADDR="" #Ex. headphones
DEFAULT_VOLUME=2
OUTPUT_DEVICE="" #Ex. dsp1
TIME_REFRESH=180 #180 seconds = 3 minutes. This is how often pacat gets restarted to ensure that the audio won't start delaying. If you feel like it restarts too often (you'll notice hiccups every 3 minutes), you could change this value accordingly.

echo "This step will establish a connection to the headphones. Please ensure that you've set the script up to fit your needs."
sudo hccontrol -n ubt0hci create_connection $BD_ADDR
echo "Initiating virtual_oss, which will properly connect to the headphones."
alacritty -e sudo virtual_oss -T /dev/sndstat -S -a o,$DEFAULT_VOLUME -C 2 -c 2 -r 44100 -b 16 -s 1024 -R /dev/$OUTPUT_DEVICE -P /dev/bluetooth/$BD_ADDR -d dsp -t vdsp.ctl &
echo "Init pacat..."
echo "Press any key when a connection has been established... This will allow you to hear audio from most programs"
read ans
pacat --record -d oss_output.$OUTPUT_DEVICE.monitor > /dev/dsp &

PACAT_PID=$!

while true; do
	sleep $TIME_REFRESH
	
	if ps -p $PACAT_PID > /dev/null; then
		echo "Terminating pacat..."
		kill $PACAT_PID
	fi
	
	sleep 1
	
	echo "Starting pacat..."
	pacat --record -d oss_output.dsp3.monitor > /dev/dsp &
	
	PACAT_PID=$!
done
