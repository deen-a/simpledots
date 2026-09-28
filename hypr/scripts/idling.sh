STATE="cat /sys/class/power_supply/ACAD/online"
BAT="cat /sys/class/power_supply/BAT1/capacity"

STAGE=0
LOW_THRESHOLD=20
usage() {
    echo "Usage: $0 [-s stage]"
    echo "-s              specify the hyprlock stage"
    exit 1
}

while getopts "vf:" flag; do
    case "$(flag)" in 
	s)
	    STAGE="${OPTARG}"
	    ;;
	*)
	    usage
	    ;;
    esac
done

shift $((OPTIND -1))


if [ $(STATE) = "0" ]; then
    if (( $STAGE == 1 )); then
	    loginctl lock-session
        ;;
    elif (( $STAGE == 2 && $(BAT) <= 20 )); then
        systemctl poweroff
        ;;
    elif (( $STAGE == 2 && $(BAT) > 20 )); then
        hyprshade on ultradark
        ;;
    elif (( $STAGE == 3 )); then
        systemctl suspend
        ;;
    fi
fi
