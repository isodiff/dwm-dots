#!/bin/bash
# A bash script that compiles the kernel
# Author : me

# Defining colors for better visuals
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Purple='\033[0;35m'       # Purple
NC='\033[0m'			  # End Color

# Default options 
VER='17.5'
NAME='517-w3cl'
Username=$USER
EnableSerialUSB=""

JOBS=$(grep -c processor /proc/cpuinfo)
echo "number of threads: $(grep -c processor /proc/cpuinfo)"
echo "Update system before running the script"

#The main function
Run()
{
	echo -e "$Red Ver. $VER Version name: $NAME Jobs: $JOBS $NC"
	echo -e "$Purple kernel builder v1 $NC"
	echo -e "$Purple Running with $JOBS jobs $NC"
	cd /home/twfl/kernelbuild/linux-5.$VER/
	pwd
	echo -e "$Purple starting build $NC"

	###* Starting the compilation
	make -j$JOBS
	if [[ $? != 0 ]]; then    
                echo -e "$Red[ ! ] Error while Compiling kernel$NC"    
                exit 1    
        fi
	make modules -j$JOBS
	if [[ $? != 0 ]]; then    
                echo -e "$Red[ ! ] Error while Compiling modules$NC"    
                exit 1    
        fi
	make modules_install
	if [[ $? != 0 ]]; then    
                echo -e "$Red[ ! ] Error while installing modules$NC"    
                exit 1    
        fi
	###*
	#----------------#
	###* Copying files and images
	echo -e "$Green finished compiling $NC"
	echo -e "$Purple installing new kernel $NC"
	cp -v arch/x86/boot/bzImage /boot/vmlinuz-linux$NAME
	cp /etc/mkinitcpio.d/linux.preset /etc/mkinitcpio.d/linux$NAME.preset
	cp System.map /boot/System.map-linux$NAME
	ln -sf /boot/System.map-linux$NAME+ /boot/System.map
	
	echo -e "$Purple making required changes $NC"
	# Changing kernel name
	sed -i "s/-linux/-linux${NAME}/g" /etc/mkinitcpio.d/linux$NAME.preset
	
	mkinitcpio -p linux$NAME
	
	echo -e "$Green finished installing kernel $NC"
	if [[ $EnableSerialUSB ]]; then
		EnableSerialPatched
    	echo "Serial ports enabled"
	else
    	echo "no files found"
	fi
	RegenerateGRUB
	echo -e "$Red Script Finished, new kernel ready $NC"
	echo -e "$Green Reboot recommended $NC"
	exit 0
}

# Enables support for patched serial drivers
EnableSerialPatched()
{
	echo -e "$Red ------------------------- $NC"
	echo -e "$Red Please unplug any serial devices $NC"
	echo -e "$Red ------------------------- $NC"
	
	sleep 5

	pacman -S arduino arduino-docs avr-binutils avr-gcc avr-libc avrdude git --needed --noconfirm
	avr=$(pacman -Qs arduino-avr-core)
	if [[ $? != 0 ]]; then
    		echo -e "$Red Pacman failed$NC"
	elif [[ $avr ]]; then
    		echo -e "$Green Package arduino-avr-core exists. Removing$NC"
		pacman -R arduino-avr-core
	else
    		echo "+"
	fi
	gpasswd -a $Username uucp
    gpasswd -a $Username lock
	if [[ $? != 0 ]]; then    
                echo -e "$Red[ ! ] Could not add user to group$NC"    
                exit 1    
        else    
                echo -e "$Green User has been added to groups 'uucp' and 'lock'$NC"    
        fi

	modprobe cdc_acm
	if [[ $? != 0 ]]; then
		echo -e "$Red[ ! ] Error$NC"
    		echo -e "$Red[ ! ] No cdc_acm module$NC"
		echo -e "$Red Please enable$NC$Purple CONFIG_USB_ACM $NC$Red in the kernel config file$NC"
		exit 1 
	else
		echo -e "$Green Module loaded successfully$NC"
	fi
        mkdir -p $HOME/.config/kernel-drivers
        cd $HOME/.config/kernel-drivers
        git clone https://github.com/juliagoda/CH341SER.git
        cd ./CH341SER/
        make
	if [[ $? != 0 ]]; then
            echo -e "$Red[ ! ] Error making driver$NC"
            exit 1 
    else
            echo -e "$Green Compiled successfully$NC"
    fi
        make load
	if [[ $? != 0 ]]; then        
                echo -e "$Red[ ! ] Error loading driver$NC"
                exit 1 
        else
                echo -e "$Green Loaded successfully$NC"     
        fi
	find . -name *.ko | xargs gzip
	cp ch34x.ko.gz /usr/lib/modules/$(uname -r)/kernel/drivers/usb/serial
	if [[ $? != 0 ]]; then        
                echo -e "$Red[ ! ] Error copying driver$NC"
                exit 1 
        else
                echo -e "$Green Copied successfully$NC"     
        fi
	if [[ $(lsmod | grep ch341) ]]; then
    		echo "ch341 exists, removing"
		sudo rmmod ch341
		mv /usr/lib/modules/$(uname -r)/kernel/drivers/usb/serial/ch341.ko.gz /lib/modules/$(uname -r)/kernel/drivers/usb/serial/ch341.ko.gz~
		depmod -a
	else
    		echo "ch341 not found"
	fi
	echo "Finished installing"
	echo "Changing permissions"
	ls /dev/ttyUSB*
	sudo usermod -a -G dialout $Username 
	chmod a+rw /dev/ttyUSB0


}

# Enables support for regular serial drivers
# EnableSerial()
# {
# 	echo -e "$Red ------------------------- $NC"
# 	echo -e "$Red Please unplug any serial devices $NC"
# 	echo -e "$Red ------------------------- $NC"
	
# 	sleep 5

# 	gpasswd -a $Username uucp
#     gpasswd -a $Username lock
# 	if [[ $? != 0 ]]; then    
#                 echo -e "$Red[ ! ] Could not add user to group$NC"    
#                 exit 1    
#         else    
#                 echo -e "$Green User has been added to groups 'uucp' and 'lock'$NC"    
#         fi

# 	modprobe cdc_acm
# 	if [[ $? != 0 ]]; then
# 		echo -e "$Red[ ! ] Error$NC"
#     		echo -e "$Red[ ! ] No cdc_acm module$NC"
# 		echo -e "$Red Please enable$NC$Purple CONFIG_USB_ACM $NC$Red in the kernel config file$NC"
# 		exit 1 
# 	else
# 		echo -e "$Green Module loaded successfully$NC"
# 	fi
#     mkdir -p $HOME/.config/kernel-drivers
#     cd $HOME/.config/kernel-drivers
#     wget https://cdn.sparkfun.com/assets/learn_tutorials/8/4/4/CH341SER_LINUX.ZIP
# 	unzip CH341SER_LINUX.ZIP
#     make
# 	if [[ $? != 0 ]]; then
#                 echo -e "$Red[ ! ] Error making driver$NC"
#                 exit 1 
#     else
#                 echo -e "$Green Compiled successfully$NC"
#     fi
#     make load
# 	if [[ $? != 0 ]]; then        
#                 echo -e "$Red[ ! ] Error loading driver$NC"
#                 exit 1 
#     else
#                 echo -e "$Green Loaded successfully$NC"     
#     fi
# 	find . -name *.ko | xargs gzip
# 	cp ch34x.ko.gz /usr/lib/modules/$(uname -r)/kernel/drivers/usb/serial
# 	if [[ $? != 0 ]]; then        
#                 echo -e "$Red[ ! ] Error copying driver$NC"
#                 exit 1 
#     else
#                 echo -e "$Green Copied successfully$NC"     
#     fi
# 	modprobe ch341
# 	echo "Finished installing"
# 	echo "Changing permissions"
# 	ls /dev/ttyUSB*
# 	sudo usermod -a -G dialout $Username 
# 	chmod a+rw /dev/ttyUSB0
# }


# Regenerates GRUB config with default options
# from /etc/default/grub
RegenerateGRUB(){
        echo -e "$Purple re-generating grub config $NC"
        grub-mkconfig -o /boot/grub/grub.cfg
        if [[ $? != 0 ]]; then    
                echo -e "$Red[ ! ] Error while re-generating GRUB config$NC"    
                exit 1    
        fi
}

# Checks if the number (of jobs) is correct
CheckInt()
{
re='^[0-9]+$'
if ! [[ $JOBS =~ $re ]] ; then
   echo -e "$Red error: Not a valid number $NC" >&2; exit 2 
fi
}


# Get the options
while getopts ":j:n:veb" option; do
   case $option in
      j) # Enter the number of jobs
         JOBS=$OPTARG
	 CheckInt;;
      e) EnableSerialUSB="1"
	  	;;
	  b) EnableSerialPatched
	     exit;;

      v) OptVer=$(dialog --title "Kernel Builder v1" --menu "Choose your version:" 20 80 2 1 17.5 2 17.7 3>&1 1>&2 2>&3 3>&-) # Enter the version Eg. 17.5
      		case "$OptVer" in
			1)
				echo "Kernel Version 17.5"
				VER="17.5";;
			2)
				echo "Kernel Version 17.7"
				VER="17.7";;
		esac;;

      n) NAME="$OPTARG";; # Enter the name Eg. 175-w3cl 

     \?) # Invalid option
         echo -e "$Res Error: Invalid option $NC"
         exit;;

   esac
done

#* Run the main function
Run