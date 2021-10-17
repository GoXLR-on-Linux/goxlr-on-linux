#!/bin/sh


echo "Output Devices"
case "${1:-}" in
    (""|list)
        outputs=$(pacmd list-sinks |
        #Filter for jack.client_name, remove quotes, number results
        grep -E 'jack.client_name' | sed 's/		jack.client_name = //g' | sed 's/"//g' | nl -ba -s') ')
        printf "$outputs \c"

        #Dummy var to trap the script in loop until an acceptable answer is input
        allowed=
        while [ ! $allowed ]; do
            #Ask which device to use
            printf "\nPlease type a number to pick a default output device (0 to skip):"
            read REPLY

            #Set selection
            selected=$(echo "$outputs" | grep -E $REPLY | sed 's/     '$REPLY') //g')

            #Check if valid option and name found
            if [ $REPLY = '0' ]; then
                echo "Skipping option."
                allowed="true"
            elif [ ! $selected ]; then
            	echo "Invalid option selected."
            else
                echo $selected "was selected."
                allowed="true"
            fi
        done
    ;;
esac

if [ $selected ]; then
    #Filter for both names, remove $selected and get line before it
    found=$(pacmd list-sinks | grep -E "$selected|name:" | grep -B 1 $selected | sed '/'$selected'/d' |
    #Sed off unneeded characters
    sed 's/[ 	<>]//g' | sed 's/name://g')

    printf "Device name is $found \c"
    echo "Use 'pacmd list-sinks' to verify that '$selected' is '$found'"
else
    echo "Must have skipped setting"
fi
