#!/bin/bash

echo "Part-1"
#Welcome
echo "Welcome to the Interactive File and Directory Explorer!"

#List
while true;
do
        echo "Files and directories in the correct path"
        ls -lh --group-directories-first | awk '{print $9, $5}'

        #text input for char count
        read -p "Enter a line of text (Press Enter without text to exit): " input

        # Exit if the user enters an empty string
        if [ -z "$input" ];
        then
                echo "Exiting the Interactive Explorer. Goodbye!"
                break
        fi

        #char_count
        char_count=$(echo -n "$input" | wc -m)
        echo "Character_count: $char_count"
done


