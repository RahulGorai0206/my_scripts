#!/bin/bash

# Take Inputs
     read -p "Select One ( 1=PPUI, 2=CHERISH, 3=EVO, 4=ELIXIR ): " rom

case $rom in
                1 )
                        mkdir -p ../rahul/ppui
                        cp clone.sh ../rahul/ppui
                        cd ../rahul/ppui
                        repo init -u https://github.com/PixelPlusUI/official_manifest -b tiramisu --depth=1 ;;
                2 )
                        mkdir -p ../rahul/cherish
                        cp clone.sh ../rahul/cherish
                        cd ../rahul/cherish
                        repo init -u https://github.com/CherishOS/android_manifest.git -b tiramisu --depth=1 ;;
                3 )
                        mkdir -p ../rahul/evo
                        cp clone.sh ../rahul/evo
                        cd ../rahul/evo
                        repo init -u https://github.com/Evolution-X/manifest -b tiramisu --depth=1 ;;
                4 )
                   	mkdir -p ../rahul/eli
                        cp clone.sh ../rahul/eli
                        cd ../rahul/eli
                        repo init -u  https://github.com/Project-Elixir/manifest -b Tiramisu --depth=1 ;;
                * )
                        echo "Invalid Input "
                        exit ;;
                        esac


     repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
# Take Inputs
     read -p "Want to resync?  (Y/N): " sync
     
 if [[ $sync == Y ]]
        then
               repo sync
               exit 0
        fi
     . clone.sh
