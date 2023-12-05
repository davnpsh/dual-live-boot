## Installation of QEMU/KVM

Now, we need to get QEMU/KVM. In Arch Linux:

```bash
sudo pacman -S qemu-full virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libguestfs swtpm
```

Depending on you distribution, the name of the packages may be different. This [guide](https://gitlab.com/risingprismtv/single-gpu-passthrough/-/wikis/4\)-Configuration-of-libvirt) contains instructions for other distros.

## Configuration

### Enable libvirtd

After that, **enable** (don't start yet) libvirtd using your init system. In my case:

```
sudo systemctl enable libvirtd
```

### Setup user account

Next, we need to enable our user account to use KVM. Use your preferred text editor to edit this file:

```bash
sudo vim /etc/libvirt/libvirtd.conf

```

Go ahead and uncomment the following lines:

```
unix_sock_group = "libvirt"
unix_sock_ro_perms = "0777"
unix_sock_rw_perms = "0770"
```

Add yourself to the libvirt group:

```
sudo usermod -aG libvirt $USER
```

Finally, reboot your system.