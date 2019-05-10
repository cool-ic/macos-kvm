## hardware

|      |  info                                              |
| -------- | ----------------------------------------------------- |
| cpu | r5 2600                 |
| board | b450m-k            |
| nvidia | gtx1070itx          |

## 
## step1

* install the vm:
    ```text
    wget https://raw.githubusercontent.com/Bebove/macos-kvm/master/install_qemu.sh
    chmod 777 install_qemu.sh
    ./install_qemu.sh
    cd ~
    cp -r /media/q/Data/mac   ~/macOS-Simple-KVM
    chmod 777 ~/macOS-Simple-KVM
    cd macOS-Simple-KVM
    ./basic.sh
     ```
## 
## step2
* install nvidia-driver

## 
## step3
* run
  ```text
  wget https://raw.githubusercontent.com/Bebove/macos-kvm/master/macos.xml
  apt-get install virt-manager
  systemctl enable libvirtd.service virtlogd.service
  systemctl start libvirtd.service virtlogd.service
  rm -rf /etc/default/grub
  cd /etc/default/
  wget https://raw.githubusercontent.com/Bebove/macos-kvm/master/grub
  chmod 777 grub
  reboot
  ```
* edit the /etc/libvirt/qemu.conf. you must uncomment these two lines:
   ```text
      user="root"
      group="root"
   ```
   and run 
   ```text
   systemctl enable libvirtd.service virtlogd.service
   systemctl start libvirtd.service virtlogd.service
   cd ~
   virsh define macos.xml
   virt-manager
   ```


* in virt-manager ,you should del old mouth/keyboard, and add new.
* go into virt-manager, add pcie nvidia card via virt-manager. you can also change the memory and the number of cpu.
* run init 3
* run 
```
cd ~
sudo systemctl enable libvirtd.service virtlogd.service
sudo systemctl start libvirtd.service virtlogd.service
sudo virsh start OSX
```

