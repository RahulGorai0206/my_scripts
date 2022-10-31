#!/bin/bash

# Declear Variables
        dt=$PWD/device/xiaomi/beryllium
        ct=$PWD/device/xiaomi/sdm845-common
        vt=$PWD/vendor/xiaomi
        HX=$PWD/hardware/xiaomi
        kt=$PWD/kernel/xiaomi/sdm845


# Clone Device Tree
function clone_dt () {
        git clone https://github.com/RahulGorai0206/device_xiaomi_beryllium.git -b $branch $dt
}

# Clone Common Tree
function clone_ct () {
        if [[ $del_branch == 1 ]]
        then
                git clone https://github.com/RahulGorai0206/device_xiaomi_sdm845-common.git $ct
        else
          git clone https://github.com/RahulGorai0206/device_xiaomi_beryllium-common.git -b $branch $ct
        fi
}

#Clone Vendor Tree
function clone_vendor () {
        git clone https://github.com/RahulGorai0206/vendor_xiaomi.git -b $branch $vt
        echo ""
}

# Clone Kernel Tree
function clone_kernel () {
        case $KERNEL in
                1 )
                        echo ""
                        echo "cloning Silvercore kernel . . ."
                        echo ""
                        git clone https://github.com/xiaomi-sdm678/android_kernel_xiaomi_mojito.git --depth=1 $kt ;;
                2 )
                        echo ""
                        echo "Cloning Kawaii kernel . . ."
                        echo ""
                        git clone https://github.com/Krtonia/kawaii_kernel_sdm845.git --depth=1 $kt
                        cd device/xiaomi/beryllium
                        sed -i "s#TARGET_KERNEL_CONFIG += vendor/xiaomi/silvercore_defconfig#TARGET_KERNEL_CONFIG := beryllium_defconfig# BoardConfig.mk
                        cd ../../.. ;;
                * )
                        echo "Invalid option :( "
        esac
}

# Clone Hardware/xiaomi
function hx_clone () {
        if [ -e $HX ] ; then
                echo " No need to clone hardware/xiaomi"
         else
                git clone https://github.com/ArrowOS-Devices/android_hardware_xiaomi.git $HX
        fi
}

# Clone Clang
function clone_clang () {
        case $cc in
                1 )
                        echo
                        echo "Cloning proton clang"
                        CCP=$PWD/prebuilts/clang/host/linux-x86/clang-proton
                        if [ -e $CCP ] ; then
                                 echo " No need to clone clang"
                         else
                                 git clone https://github.com/kdrag0n/proton-clang --depth=1 prebuilts/clang/host/linux-x86/clang-proton
                        fi ;;
                2 )
                        echo
                        echo "cloning Neutron clang"
                        CCN=$PWD/prebuilts/clang/host/linux-x86/clang-neutron
                        if [ -e $CCN ] ; then
                                 echo " No need to clone clang"
                         else
                                 git clone https://gitlab.com/dakkshesh07/neutron-clang.git --depth=1 prebuilts/clang/host/linux-x86/clang-neutron
                        fi ;;
                * )
                        echo "Using default clang" ;;
        esac
}

# Change Branch
function change_branch () {
                read -p "Enter branch name for common tree : " ch_branch
                git clone https://github.com/RahulGorai0206/device_xiaomi_beryllium-common.git -b $ch_branch $ct
                read -p "Enter branch name for device tree : " ch_branch
                git clone https://github.com/RahulGorai0206/device_xiaomi_beryllium.git -b $ch_branch $dt
                read -p "Enter branch name for vendor tree : " ch_branch
                git clone https://github.com/RahulGorai0206/vendor_xiaomi.git -b $ch_branch $vt
                clone_kernel
                hx_clone
                clone_clang
}

echo ""

# Gh auth
gh auth login

# Take Inputs
     read -p "Enter Build Type (1=A13, 2=A12.1, 3=Test, 4=Private): " type
     read -p "Enter kernel name (1=Silvercore, 2=Kawaii): " KERNEL
     read -p "Enter the clang name (1=Proton, 2=Neutron): " cc
     read -p "Want to Change branches? (y/n): " cb
     
     
 if [[ $cb == y ]]
        then
               change_branch
               exit 0
        fi
     
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


# Call Functions
clone_dt
clone_ct
clone_kernel
clone_vendor
hx_clone
clone_clang

exit 0
