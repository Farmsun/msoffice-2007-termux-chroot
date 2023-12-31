printf "\033[92mUpdating repositories...\n\033[0m"
apt update

printf "\033[92m\nUpdating system...\n\033[0m"
apt upgrade -y

#printf "\033[92m\nInstalling required packages...\n\033[0m"
#printf "apt install proot proot-distro wget -y"

#printf "\033[92m\nInstalling Ubuntu...\n\033[0m"
#printf "proot-distro install --override-alias office2007 ubuntu"

printf "\033[92m\nDownloading files...\n\033[0m"
printf "\033[33m\nDownloading box86...\n\033[0m"
curl "https://dl.dropboxusercontent.com/s/arftb8ije5c41vb/box86" --output box86

printf "\033[33m\nDownloading Wine (version 8.0.1)...\n\033[0m"
curl -O -J -L "https://github.com/Kron4ek/Wine-Builds/releases/download/8.0.1/wine-8.0.1-x86.tar.xz"
mv wine-8.0.1-x86.tar.xz wine.tar.xz

printf "\033[33m\nDownloading Microsoft Office 2007 Setup...\n\033[0m"
curl "https://dl.dropboxusercontent.com/s/b7rr1ss7w6gwged/office2007.tgz" --output office2007.tgz

printf "\033[33m\nDownloading Wine base drive...\n\033[0m"
curl "https://dl.dropboxusercontent.com/s/pebk0amy7ukeop2/basedrive.tgz" --output basedrive.tgz

printf "\033[33m\nDownloading misc files...\n\033[0m"
curl "https://dl.dropboxusercontent.com/s/sb9ekwr68r1hobb/misc.tgz" --output misc.tgz
printf "\033[92m\nDownloading files finished\n\033[0m"

printf "\033[92m\nExtracting files...\n\033[0m"
printf "\033[33m\nExtracting Wine...\n\033[0m"
tar xvf wine.tar.xz
rm wine.tar.xz
mv wine-8.0.1-x86 wine

printf "\033[33m\nExtracting Microsoft Office 2007 Setup...\n\033[0m"
tar xvf office2007.tgz
rm office2007.tgz

printf "\033[33m\nExtracting Wine base drive...\n\033[0m"
tar xvf basedrive.tgz
rm basedrive.tgz

printf "\033[33m\nExtracting misc files...\n\033[0m"
tar xvf misc.tgz
rm misc.tgz
printf "\033[92m\nExtracting files finished\n\033[0m"

printf "\033[92m\nCopying files to proot distro...\n\033[0m"
mkdir -p /root/files
printf "\033[33mCopying box86...\n\033[0m"
cp box86 /root/files/box86

printf "\033[33mCopying Wine...\n\033[0m"
cp -r wine /root/files/wine

printf "\033[33mCopying Microsoft Office 2007 Setup...\n\033[0m"
cp -r office2007setup /root/files/office2007setup

printf "\033[33mCopying Wine base drive...\n\033[0m"
cp -r base /root/.wine

printf "\033[33mCopying misc files...\n\033[0m"
cp -r misc /root/files/misc
printf "\033[92mCopying files fininshed\n\033[0m"

#printf "\033[33m\nDownloading 2nd script...\n\033[0m"
#curl "https://dl.dropboxusercontent.com/s/wbu0wng0ez11i4o/2ndscript.sh" --output script.sh-
#dos2unix -n script.sh- script.sh
#rm script.sh-

#printf "\033[33mCopying 2nd script...\n\033[0m"
#cp script.sh /root/script.sh
#chmod +x /root/script.sh
#printf "\033[92mFinished\n\033[0m"

#printf "\033[92m\nStarting proot distro...\n\033[0m"
#proot-distro login office2007 -- "/root/script.sh"

#printf "\033[92m\n\nInstallation finished!\n\033[0m"
#printf "\033[92m\nYou can log into proot distro with this command:\n\033[0m"
#printf "\033[36mproot-distro login office2007\n\033[0m"
#printf "\033[92m\nEnjoy Microsoft Office 2007 on your device!\n\033[0m"




dpkg --add-architecture armhf
chmod +x /root/files/box86

printf "\033[92m\nUpdating repositories...\n\033[0m"
apt update

printf "\033[92m\nUpdating system...\n\033[0m"
apt upgrade -y

printf "\033[92m\nInstalling required packages...\n\033[0m"
apt install libasound2:armhf libc6:armhf libglib2.0-0:armhf libgphoto2-6:armhf libgphoto2-port12:armhf libgstreamer-plugins-base1.0-0:armhf libgstreamer1.0-0:armhf libpcap0.8:armhf libpulse0:armhf libsane1:armhf libudev1:armhf libusb-1.0-0:armhf libx11-6:armhf libxext6:armhf ocl-icd-libopencl1:armhf libasound2-plugins:armhf libncurses6:armhf libcap2-bin:armhf libcups2:armhf libdbus-1-3:armhf libfontconfig1:armhf libfreetype6:armhf libglu1-mesa:armhf libgnutls30:armhf libgssapi-krb5-2:armhf libkrb5-3:armhf libodbc1:armhf libosmesa6:armhf libsdl2-2.0-0:armhf libv4l-0:armhf libxcomposite1:armhf libxcursor1:armhf libxfixes3:armhf libxi6:armhf libxinerama1:armhf libxrandr2:armhf libxrender1:armhf libxxf86vm1:armhf gcc-arm-linux-gnueabihf xfce4 xfce4-goodies tightvncserver -y

printf "\033[33mCreating symlinks...\n\033[0m"
cp /root/files/box86 /bin/box86
ln -s /root/files/wine/bin/wine /bin/wine
ln -s /root/files/wine/bin/wineserver /bin/wineserver

printf "\033[92mSetting up VNC server...\n\033[0m"
mkdir -p /root/.vnc
mv /root/files/misc/passwd /root/.vnc
chmod -rw------- /root/.vnc/passwd

vncserver :1
sleep 1
vncserver -kill :1

echo "startxfce4 &" >> /root/.vnc/xstartup
printf "\033[92mFinished\n\033[0m"
sleep 1

printf "\033[92mStarting VNC server...\n\033[0m"
vncserver -geometry 1920x1080 :1

printf "\033[96mPlease connect to the VNC server.\n\033[0m"
printf "\033[96mVNC server IP address: localhost:1\n\033[0m"
printf "\033[96mVNC server password: off2007\n\033[0m"
printf "\033[96mMicrosoft Office 2007 product key: GMG3P-FHGXW-VTQ94-4QW8F-VG2HM\n\033[0m"
printf "\033[39m\nPress any key to start the Microsoft Office 2007 installer\n\033[0m"
read -p ""
export DISPLAY=:1
box86 wine /root/files/office2007setup/setup.exe
printf "\033[92m\nSetup finished\n\033[0m"

printf "\033[33m\nCreating shortcuts...\n\033[0m"

mkdir -p /root/Desktop
mv /root/files/misc/excel.desktop /root/Desktop
mv /root/files/misc/powerpoint.desktop /root/Desktop
mv /root/files/misc/word.desktop /root/Desktop

mkdir -p /usr/share/icons/office
mv /root/files/misc/excel.svg /usr/share/icons/office
mv /root/files/misc/powerpoint.svg /usr/share/icons/office
mv /root/files/misc/word.svg /usr/share/icons/office

rm -r /root/files/misc

printf "\033[92m\nFinishing...\n\033[0m"
touch /root/.bashrc
echo "rm -rf /tmp/.X1-lock" >> /root/.bashrc 
echo "rm -rf /tmp/.X11-unix/X1" >> /root/.bashrc
echo "vncserver -geometry 1920x1080 :1" >> /root/.bashrc
echo "printf \"\033[92m\nVNC server started.\n\033[0m\"" >> /root/.bashrc
echo "printf \"\033[96mVNC server IP address: localhost:1\n\033[0m\"" >> /root/.bashrc
echo "printf \"\033[96mVNC server password: off2007\n\033[0m\"" >> /root/.bashrc
echo "printf \"\033[92m\nTo quit out of here, type this command:\n\033[0m\"" >> /root/.bashrc
echo "printf \"\033[96mexit\n\033[0m\"" >> /root/.bashrc
