## hardware

|      |  info                                              |
| -------- | ----------------------------------------------------- |
| cpu | r5 2600                 |
| board | b450m-k            |
| nvidia | gtx1070itx          |

## 
## step1
* install kubuntu 18.10. It is better to use a kde version of ubuntu.
* (if in china,add tuna apt source ) and make a full upgrade
* install the qemu v4.0
  ```text
  cd /etc/apt
  rm -rf sources.list
  wget https://raw.githubusercontent.com/Bebove/macos-kvm/master/sources.list
  chmod 777 sources.list
  apt-get update -y
  apt-get upgrade -y
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
  apt-get install libglib2.0-dev libpango1.0-dev libatk1.0-dev -y
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
  
  

  ```
 * maybe you should update your pip ,and use tuna source if you are in china
 * install vm:
    ```text
    cd ~
    git clone https://github.com/foxlet/macOS-Simple-KVM.git
    cd macOS-Simple-KVM
    ./jumpstart.sh  #Note that you can speed the download by replace the 1024 by a bigger number in  'macOS-Simple-KVM/tools/FetchMacOS/fetch-macos.py'
    qemu-img create -f qcow2 MyDisk.qcow2 64G
    ```
 * adding these 2 lines to the included basic.sh script
     ```text
         -drive id=SystemDisk,if=none,file=MyDisk.qcow2 \
         -device ide-hd,bus=sata.4,drive=SystemDisk \
     ```
## 
## step2
* run basic.sh, install the macos to MyDisk, and you can change the resolution of in clover plist.

...to be continue

## 
## trash code(do not use)
```text
--enable-vte  --target-list=x86_64-softmmu
  apt-get install -y qemu-system-gui
  apt-get install qemu-block-extra qemu-slof qemu-system qemu-system-arm qemu-system-common qemu-system-mips qemu-system-misc qemu-system-ppc qemu-system-s390x qemu-system-sparc qemu-system-x86 qemu-user qemu-user-binfmt qemu-utils -y
  apt install libvirt-bin libvirt-daemon libvirt0  -y
```
