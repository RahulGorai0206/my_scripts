#!/bin/bash

read -p "Enter Build Type (1=A13, 2=A12.1, 3=Test, 4=Private): " type
case $type in
                1 )
                        echo
                        echo "Cloning A13 Resources ......."
                        branch= "thirteen"
                        del_branch=0
                2 )
                        echo
                        echo "Cloning A12.1 Resources ......."
                        branch="twelve.one"
                        del_branch=0
                3 )
                        echo
                        echo "Cloning Testing Resources ......."
                        branch="test"
                        del_branch=0
                4 )
                        echo "Cloning Private Resources ......."
                        branch="thirteen"
                        del_branch=1
                * )
                        echo "Invalid Input " 
                        exit ;;

function clone_dt () {
        dt=$PWD/device/xiaomi/beryllium
        git clone https://github.com/RahulGorai0206/device_xiaomi_beryllium.git -b $branch $dt
}

function clone_ct () {
        ct=$PWD/device/xiaomi/sdm845-common
        if [[ $del_branch == 1 ]]
        then
                git clone https://github.com/RahulGorai0206/device_xiaomi_sdm845-common.git $ct
        else
          git clone https://github.com/RahulGorai0206/device_xiaomi_beryllium-common.git -b $branch $ct
        fi
}

function clone_vendor () {
        vt=$PWD/vendor/xiaomi
        git clone https://github.com/RahulGorai0206/vendor_xiaomi.git -b $branch $vt
        echo ""
}

function clone_kernel () {
     read -p "Enter kernel name (1=Silvercore, 2=Kawaii : " KERNEL
        case $KERNEL in
                1 )
                        echo ""
                        echo "cloning Silvercore kernel . . ."
                        echo ""
                        git clone https://github.com/xiaomi-sdm678/android_kernel_xiaomi_mojito.git --depth=1 kernel/xiaomi/sdm845 ;;
                2 )
                        echo ""
                        echo "Cloning Kawaii kernel . . ."
                        echo ""
                        git clone https://github.com/Krtonia/kawaii_kernel_sdm845.git --depth=1 kernel/xiaomi/sdm845 ;;
                * )
                        echo "Invalid option :( "
        esac
}

function hx_clone () {
        HX=$PWD/hardware/xiaomi
        GHX="git clone https://github.com/ArrowOS-Devices/android_hardware_xiaomi.git $HX"
        if [ -e $HX ] ; then
                read -p "$HX Exists. Do you want do remove and re-clone $HX Y/n " HX_OPTION
                if [[ $HX_OPTION == Y ]]
                then
                rm -rf $HX
                $GHX
                fi
        
         else
                $GHX
                echo ""
        fi
}

function clone_clang () {
     read -p "Enter the clang name (1=Proton, 2=Neutron): " cc
        case $cc in
                1 )
                        echo
                        echo "Cloning proton clang"
                        git clone https://github.com/kdrag0n/proton-clang --depth=1 prebuilts/clang/host/linux-x86/clang-proton ;;
                2 )
                        echo
                        echo "cloning Neutron clang"
                        git clone https://gitlab.com/dakkshesh07/neutron-clang.git --depth=1 prebuilts/clang/host/linux-x86/clang-neutron ;;
                * )
                        echo "Using default clang" ;;
        esac
}
echo ""

clone_dt
clone_ct
clone_kernel
clone_vendor
hx_clone
clone_clang

exit 0
