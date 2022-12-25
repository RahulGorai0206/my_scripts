#!/bin/bash

# Take Inputs
     read -p "Select One ( 1=PPUI, 2=CHERISH, 3=EVO ): " rom

case $rom in
                1 )
                        mkdir -p ../rahul/ppui
                        cp clone.sh ../rahul/ppui
                        cd ../rahul/ppui
                        repo init --depth=1 -u https://github.com/PixelPlusUI/official_manifest -b tiramisu
                        repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
                        . clone.sh ;;
                2 )
                        mkdir -p ../rahul/cherish
                        cp clone.sh ../rahul/cherish
                        cd ../rahul/cherish
                        repo init -u https://github.com/CherishOS/android_manifest.git -b tiramisu --depth=1
                        repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
                        . clone.sh ;;
                3 )
                        mkdir -p ../rahul/evo
                        cp clone.sh ../rahul/evo
                        cd ../rahul/evo
                        repo init -u https://github.com/Evolution-X/manifest -b tiramisu --depth=1
                        repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
                        . clone.sh ;;
                * )
                        echo "Invalid Input "
                        exit ;;
                        esac
