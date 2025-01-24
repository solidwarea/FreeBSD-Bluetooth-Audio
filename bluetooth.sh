$bd_addr = "" #Ex. headphones
$defaut_volume = 2
$output = "" #Ex. dsp1
$refresh = 180 #180 seconds = 3 minutes. This is how often pacat gets restarted to ensure that the audio won't start delaying. If you feel like it restarts too often (you'll notice hiccups every 3 minutes), you could change this value accordingly.

echo "This step will establish a connection to the headphones. Please ensure that you've set the script up to fit your needs."
sudo hccontrol -n ubt0hci create_connection $bd_addr
echo "Initiating virtual_oss, which will properly connect to the headphones."
alacritty -e sudo virtual_oss -T /dev/sndstat -S -a o,$defaut_volume -C 2 -c 2 -r 44100 -b 16 -s 1024 -R /dev/$output -P /dev/bluetooth/$bd_addr -d dsp -t vdsp.ctl &
echo "Init pacat..."
echo "Press any key when a connection has been established... This will allow you to hear audio from most programs"
read ans
pacat --record -d oss_output.$output.monitor > /dev/dsp &

PACAT_PID=$!

while true; do
	sleep $refresh
	
	if ps -p $PACAT_PID > /dev/null; then
		echo "Terminating pacat..."
		kill $PACAT_PID
	fi
	
	sleep 1
	
	echo "Starting pacat..."
	pacat --record -d oss_output.dsp3.monitor > /dev/dsp &
	
	PACAT_PID=$!
done
