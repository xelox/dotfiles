secondary="monitor = DP-4, 1920x1080@165, 0x0, 1"
main_60="monitor = DP-5, 1920x1080@60, 1920x0, 1"
main_165="monitor = DP-5, 1920x1080@165, 1920x0, 1"
output=~/.config/hypr/monitors.conf

mode=$(head -n 1 $output)

if [ "$mode" = "# 1" ]
then
    echo -e "# 2\n$secondary\n$main_60" > $output
else
    echo -e "# 1\n$secondary\n$main_165" > $output
fi
    
