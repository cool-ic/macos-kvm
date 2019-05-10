cd /etc/apt
rm -rf sources.list
wget https://raw.githubusercontent.com/Bebove/macos-kvm/master/sources.list
chmod 777 sources.list
apt-get update -y
apt-get upgrade -y
apt-get install openssh-server
apt-get install python python-pip git axel -y
pip install --upgrade pip  -i https://pypi.tuna.tsinghua.edu.cn/simple
sed -i '$d' /usr/bin/pip
sed -i '$d' /usr/bin/pip
sudo sed -i '$d' /usr/bin/pip
sudo echo 'from pip import __main__' >> /usr/bin/pip
sudo echo 'if __name__ == '__main__':' >> /usr/bin/pip
sudo echo -e '\t sys.exit(__main__._main())' >> /usr/bin/pip
pip install pip -U
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip install click request
apt-get install pkg-config -y
apt install libvirt-bin libvirt-daemon libvirt0  -y
apt-get install libjpeg-dev  libspice-server1 -y
apt-get install libopus-dbg  libvte-2.91-dev  libopus-dev curl opus* -y
apt-get install  libepoxy-dev  libgbm-dev  liblzo2-dev libpmem-dev libssl-dev libgtk-3-dev  libsdl2-dev  libsdl-dev -y

cd ~
wget https://www.spice-space.org/download/releases/spice-protocol-0.12.15.tar.bz2
tar jxf spice-protocol-0.12.15.tar.bz2
cd spice-protocol-0.12.15/
./configure 
make -j12
make install

apt-get update -y
apt-get upgrade -y
cd ~

axel -n 64 https://www.spice-space.org/download/releases/spice-server/spice-0.14.1.tar.bz2
tar jxf spice-0.14.1.tar.bz2 
cd spice-0.14.1/
./configure 
make -j12
make install
cd ~

wget https://github.com/libusb/libusb/archive/v1.0.22.zip
unzip v1.0.22.zip
cd  libusb-1.0.22/
aclocal
aclocal --install
autoconf
autoheader 
libtoolize
automake --add-missing
./configure 
make -j12
make install 




axel -n 128 https://download.qemu.org/qemu-4.0.0.tar.xz
tar xvJf qemu-4.0.0.tar.xz
cd qemu-4.0.0
./configure --enable-gtk   --enable-sdl --enable-opengl --enable-lzo --enable-libusb 
make -j12
make install
