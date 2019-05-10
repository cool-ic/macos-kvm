## hardware

|      |  info                                              |
| -------- | ----------------------------------------------------- |
| cpu | r5 2600                 |
| board | b450m-k            |
| nvidia | gtx1070itx          |

## 
## step1
* install ubuntu 18.04. It is better to use the same version of ubuntu.
* run install_qemu.sh. Which will install qemu4.0.0 for you
* install the vm:
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
* run basic.sh, install the macos to MyDisk normally, then you should change the resolution of in clover plist to your display resolution .
* Also, please change the boot resolution: 
Boot your VM, and press escape at the first UEFI dialog. Type exit, hit enter. This should bring you to the OVMF configuration menu. Navigate to Device Configuration > OVMF Platform Features, and set the resolution to the same value as your VM resolution. If you did not change your VM resolution, set it to 1280×720. Hit f10, Y, then press escape until you’re in the main dialog. hit continue and boot into the VM. Shut it down fully, then Boot again to make sure the change didn’t cause any issues.
* now, your vm is working normally. then go to step3 to config the virt-manager


## 
## step3
* run
  ```text
  apt-get install virt-manager
  systemctl enable libvirtd.service virtlogd.service
  systemctl start libvirtd.service virtlogd.service
  ```
* edit the /etc/libvirt/qemu.conf. you must uncomment these two lines:
   ```text
      user="root"
      group="root"
   ```
   and run 
   ```text
   systemctl restart libvirtd.service virtlogd.service
   ```
* download the xml, edit the paths in it to your own path!!
* run 
 ```text
 virsh define macos.xml
 virt-manager
 ```
* then you can see a gui vm manager. run the macos, it should work
* then install the nvidia driver with in the osx. halt it.
* in virt-manager ,you should del old mouth/keyboard, and add new.
* use 
```text
  lspci -nn |grep NVIDIA
```
  to get the iommuid of nvidiacard
  you can use the grub setting above. just to change the id of iommu. then reboot
* go into virt-manager, add pcie nvidia card via virt-manager. you can also change the memory and the number of cpu.
* run init 3
* run 
```
cd ~
sudo systemctl enable libvirtd.service virtlogd.service
sudo systemctl start libvirtd.service virtlogd.service
sudo virsh start OSX
```

