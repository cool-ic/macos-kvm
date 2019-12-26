## A full guide on how to install macos with gpu passthrough on AMD cpu and single nvidia card.
## You need to make sure that your mother board supports iommu.
## hardware

|      |  info                                              |
| -------- | ----------------------------------------------------- |
| cpu | r5 2600                 |
| board | b450m-k            |
| nvidia | gtx1070itx          |

## 
## step1
* install ubuntu 18.04. It is better to use the same version of ubuntu.
* run install_qemu.sh. Which will install qemu4.0.0 for you.
* install the vm,provided by passthroughpo.st:
    ```text
    cd ~
    git clone https://github.com/Bebove/macOS-Simple-KVM
    cd macOS-Simple-KVM
    ./jumpstart.sh  #This will download High Sierra. Note that you can speed the download by replace the 1024 by a bigger number in  'macOS-Simple-KVM/tools/FetchMacOS/fetch-macos.py'
    qemu-img create -f qcow2 MyDisk.qcow2 64G
    ```
* adding these 2 lines to the  basic.sh script
     ```text
         -drive id=SystemDisk,if=none,file=MyDisk.qcow2 \
         -device ide-hd,bus=sata.4,drive=SystemDisk \
     ```
## 
## step2
* run basic.sh,this scripe help you boot the vm.
* Install the macos to 'MyDisk' normally. You need to format 'MyDisk' first.
* Then you should change the 'ScreenResolution' in clover plist to your display resolution. You may need 'Clover Configurator' to mount EFI,and modify the clover plist.
```text
<key>ScreenResolution</key>
<string>1280x720</string>
```
* Also, please change the boot resolution: 
```text
Boot your VM, and press escape at the first UEFI dialog. 
Type exit, hit enter. This should bring you to the OVMF configuration menu. 
Navigate to Device Configuration > OVMF Platform Features
and set the resolution to the same value as your VM resolution. 
If you did not change your VM resolution, set it to 1280×720. 
Hit f10, Y, then press escape until you’re in the main dialog. 
hit continue and boot into the VM. Shut it down fully
then Boot again to make sure the change didn’t cause any issues.
```
* now, if your vm is working normally, then go to step3 to the virt-manager, which will help you add gpu passthrough.


## 
## step3
* Run those to install and enable virt-manager.
  ```text
  apt-get install virt-manager -y
  systemctl enable libvirtd.service virtlogd.service
  systemctl start libvirtd.service virtlogd.service
  ```
* Edit the /etc/libvirt/qemu.conf. you must uncomment these two lines:
   ```text
      user="root"
      group="root"
   ```
   and run 
   ```text
   systemctl restart libvirtd.service virtlogd.service
   ```
* Download the xml from this repo, edit all the paths in it to your own path!!
* Now you can change the cpu number of vm. change the two '8' in xml:
```text
  <vcpu  placement='static'>8</vcpu>
```
```text
  <cpu>
    <topology sockets='1' cores='8' threads='1'/>
  </cpu>
```
* Run 
 ```text
 virsh define macos.xml
 virt-manager
 ```
* Then you can see a gui vm manager. run the macos, it should work fine.
* Install the nvidia driver with in the osx vm. You need to download and install nvidia web driver for your osx verson. Then reboot and shut down.

## 
## step4
* In virt-manager ,you should delete the old mouse/keyboard. There are two mouse and two keyboards listed in macos vm in virt-manager and only one pair can be deleted. Delete one pair which can be deleted.
* Add new mouth/keyboard, which can be added by click 'add hardware --> usb host device'
* use 
```text
  lspci -nn |grep NVIDIA
```
  to get the iommu_id of nvidiacard. 
* Download grub in this repo
  Delete the /etc/default/grub, and put the grup downloaded in there. Change the two 
  ```text
  vfio-pci.ids=10de:1b81,10de:10f0
  ```
  in grup to the iommu_id found by 
  ```text
  lspci -nn |grep NVIDIA
  ```
  then reboot your computer.
* go into virt-manager, add nvidia card via virt-manager. 'add hardware --> PCI host device' . There are two to add.
 which may seem like:
 ![Image text](https://raw.githubusercontent.com/Bebove/macos-kvm/master/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202019-05-12%20%E4%B8%8B%E5%8D%889.20.02.png)
* you can also change the memory of vm in virt-manager.
* run 
```text
init 3
```
to free the gpu from ubuntu,and login
* run 
```
cd ~
sudo systemctl enable libvirtd.service virtlogd.service
sudo systemctl start libvirtd.service virtlogd.service
sudo virsh start OSX
```

