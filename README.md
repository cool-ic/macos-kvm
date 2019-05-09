## hardware

|      |  info                                              |
| -------- | ----------------------------------------------------- |
| cpu | r5 2600                 |
| board | b450m-k            |
| nvidia | gtx1070itx          |

## 
## step1
* install kubuntu18.04.2. It is better to use a kde version of ubuntu
* (if in china,add tuna apt source ) and make a full upgrade
* install the qemu v4.0
  ```text
  apt-get update -y
  apt-get upgrade -y
  apt-get install pkg-config -y
  apt-get install libjpeg-dev -y
  apt-get install libopus-dbg libopus-dev curl opus* -y
  apt-get install python python-pip git -y
  apt-get install libglib2.0-dev libpango1.0-dev libatk1.0-dev -y
  apt-get update -y
  apt-get upgrade -y
  cd ~
  apt-get install libssl-dev
  wget https://www.spice-space.org/download/releases/spice-protocol-0.12.15.tar.bz2
  tar jxf spice-protocol-0.12.15.tar.bz2
  cd spice-protocol-0.12.15/
  ./configure 
  make
  make install
  cd ..
  wget https://www.spice-space.org/download/releases/spice-server/spice-0.14.1.tar.bz2
  tar jxf spice-0.14.1.tar.bz2 
  cd spice-0.14.1/
  ./configure 
  make 
  make install
  cd ..
  wget https://download.qemu.org/qemu-4.0.0.tar.xz
  tar xvJf qemu-4.0.0.tar.xz
  cd qemu-4.0.0
  ./configure 
  make -j4
  make install
  apt-get install qemu-block-extra qemu-slof qemu-system qemu-system-arm qemu-system-common qemu-system-mips qemu-system-misc qemu-system-ppc qemu-system-s390x qemu-system-sparc qemu-system-x86 qemu-user qemu-user-binfmt qemu-utils -y
  ```
 * maybe you should update your pip ,and use tuna source if you are in china
 * install vm:
    ```text
    pip install click request
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
