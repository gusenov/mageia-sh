#!/bin/bash

# Usage:
#  ./comment.sh -d=lightdm --disable

# See also:
#  https://unix.stackexchange.com/questions/271661/disable-gnome-keyring-daemon

function _disable
{
	sed -e '/gnome_keyring/ s/^#*/#/g' -i /etc/pam.d/passwd
}

function _enable
{
	sed -e '/gnome_keyring/ s/^#*//g' -i /etc/pam.d/passwd
}

# SDDM (Simple Desktop Display Manager)

function sddm_disable
{
	sed -e '/gnome_keyring/ s/^#*/#/g' -i /etc/pam.d/sddm

	_disable
}

function sddm_enable
{
	sed -e '/gnome_keyring/ s/^#*//g' -i /etc/pam.d/sddm

	_enable
}

# GDM (GNOME Display Manager)

function gdm_disable
{
	echo "DISPLAYMANAGER=gdm"
	echo "Disable of the gnome-keyring-daemon on login"

	sed -e '/gnome_keyring/ s/^#*/#/g' -i /etc/pam.d/gdm-autologin
	sed -e '/gnome_keyring/ s/^#*/#/g' -i /etc/pam.d/gdm-password
	sed -e '/gnome_keyring/ s/^#*/#/g' -i /etc/pam.d/gdm-pin
	
	_disable
}

function gdm_enable
{
	echo "DISPLAYMANAGER=gdm"
	echo "Enable of the gnome-keyring-daemon on login"

	sed -e '/gnome_keyring/ s/^#*//g' -i /etc/pam.d/gdm-autologin
	sed -e '/gnome_keyring/ s/^#*//g' -i /etc/pam.d/gdm-password
	sed -e '/gnome_keyring/ s/^#*//g' -i /etc/pam.d/gdm-pin

	_enable
}

# LXDM (LXDE Display Manager)

function lxdm_disable
{
	sed -e '/gnome_keyring/ s/^#*/#/g' -i /etc/pam.d/lxdm

	_disable
}

function lxdm_enable
{
	sed -e '/gnome_keyring/ s/^#*//g' -i /etc/pam.d/lxdm

	_enable
}

# LightDM (The Light Display Manager)

function lightdm_disable
{
	echo "DISPLAYMANAGER=lightdm"
	echo "Disable of the gnome-keyring-daemon on login"
	
	echo "/etc/pam.d/lightdm"
	sed -e '/gnome_keyring/ s/^#*/#/g' -i /etc/pam.d/lightdm
	cat /etc/pam.d/lightdm

	_disable
}

function lightdm_enable
{
	echo "DISPLAYMANAGER=lightdm"
	echo "Enable of the gnome-keyring-daemon on login"

	echo "/etc/pam.d/lightdm"
	sed -e '/gnome_keyring/ s/^#*//g' -i /etc/pam.d/lightdm
	cat /etc/pam.d/lightdm

	_enable
}

# XDM (X Display Manager)

function xdm_disable
{
	_disable
}

function xdm_enable
{
	_enable
}

function all_disable
{
	sddm_disable
	gdm_disable
	lxdm_disable
	lightdm_disable
	xdm_disable
}

function all_enable
{
	sddm_enable
	gdm_enable
	lxdm_enable
	lightdm_enable
	xdm_enable
}

for i in "$@"; do
  case $i in

    -d=*|--displaymanager=*)
	display_manager="${i#*=}"
	shift # past argument=value
	;;

    --enable)
	case $display_manager in 
		'gdm')
			gdm_enable
		;; 
		
		'lightdm')
			lightdm_enable
		;; 
		*)
			all_enable
		;;
	esac
	shift # past argument with no value
	;;

    --disable)
	case $display_manager in 
		'gdm')
			gdm_disable
		;; 
		
		'lightdm')
			lightdm_disable
		;; 
		*)
			all_disable
		;;
	esac
	shift # past argument with no value
	;;

  esac
done


