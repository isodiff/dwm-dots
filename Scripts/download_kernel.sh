#!/bin/bash
#	Example links
###	https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.117.tar.xz    | Stable
###	https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.17.9.tar.xz      | Stable
###	https://git.kernel.org/torvalds/t/linux-5.18-rc7.tar.gz		      | Mainline

#newAr=()
#array=("90" "23" "56" "5" "10" "27")
#for i in "${!array[@]}"
#do
#      echo " index---------------content"
#      echo " $i                  ${array[$i]}"
#      newAr+=($((i+1)))
#      newAr+=(${array[$i]})
#
#done
#echo ${newAr[@]}
#echo ${array[@]}
#
#CHOICE=$(dialog  --title "tytu" \
#                 --menu "Wybierz" \
#                 25 75 16 \
#                 "${newAr[@]}" \
#                 3>&1 1>&2 2>&3 3>&-)

cd $HOME/kernelbuild

StablePrefix="https://cdn.kernel.org/pub/linux/kernel/"
shopt -s nullglob
LOCAL_VER=(*/)
shopt -u nullglob
echo "${LOCAL_VER[@]}"

if (( ${#LOCAL_VER[@]} == 0 )); then
    echo "No subdirectories found" >&2
fi

main(){
	KerVer="linux-"
	echo -e "Kernel Downloader v1"
	REL=$(dialog --title "Kernel Downloader v1" --keep-tite --menu "Choose kernel release" 20 80 2 1 4 2 5 3>&1 1>&2 2>&3 3>&-)
	case $REL in
		1)
			echo none
			REL="4"
			;;
		2)
			VER=$(dialog --title --keep-tite "Kernel Downloader v1" --menu "Choose kernel version" 20 80 2 1 5.17.5 2 5.17.7 3>&1 1>&2 2>&3 3>&-)
			REL="5"
			REMOTE_VER=( $(lynx $StablePrefix/v5.x/ --dump | grep -oh 'linux-.*tar.gz') )
			printf -- '%s\n' "${REMOTE_VER[@]}" | grep -m 1 '5.17.5'
			case $VER in
				1)
					VER="17.5";;
			
				2)
					VER="17.7";;
			esac
			;;
	esac
	KerVer+=$REL"."$VER"/"
	echo $KerVer

	if [[ " ${LOCAL_VER[*]} " =~ " $KerVer " ]]; then
	echo Kernel is downloaded
	fi

	if [[ ! " ${LOCAL_VER[*]} " =~ " $KerVer " ]]; then
	echo Kernel is not downloaded
	fi
}
main
