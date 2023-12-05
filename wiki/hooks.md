## Preparing for hooks

From the [Passthrough Post blog](https://passthroughpo.st/simple-per-vm-libvirt-hooks-with-the-vfio-tools-hook-helper/):

> The hook helper itself is only a single script at the moment, so installation is simple. All you need to do is save this file in /etc/libvirt/hooks.

To install the hook helper execute every command in order

1. `sudo mkdir -p /etc/libvirt/hooks`

2. `sudo wget 'https://raw.githubusercontent.com/PassthroughPOST/VFIO-Tools/master/libvirt_hooks/qemu' -O /etc/libvirt/hooks/qemu`

3. `sudo chmod +x /etc/libvirt/hooks/qemu`

4. `sudo systemctl restart libvirtd`

The hook helper should now be ready.

## Hooks

From the blog linked above we only need 2 types of hooks:

```
# Before a VM is started, before resources are allocated:
/etc/libvirt/hooks/qemu.d/$vmname/prepare/begin/*

# After a VM has shut down, after resources are released:
/etc/libvirt/hooks/qemu.d/$vmname/release/end/*
```

We need to create the appropiate path for our hooks (in my case, `$vmname` is `win11`):

```
sudo mkdir -p /etc/libvirt/hooks/qemu.d/win11/{prepare/begin,release/end}
```

We can place now our scripts in their respective directories:

```bash
/etc/libvirt/hooks/qemu.d/win11/prepare/begin/start.sh
--------------------------------------------------------------------------

NVIDIA_GPU_VIDEO=pci_0000_01_00_0
NVIDIA_GPU_AUDIO=pci_0000_01_00_1

# Unload NVIDIA kernel modules
rmmod nvidia_modeset nvidia_uvm nvidia

# Load VFIO kernel modules
modprobe -i vfio_pci vfio_pci_core vfio_iommu_type1

# Unbind the GPU from host
virsh nodedev-detach $NVIDIA_GPU_VIDEO
virsh nodedev-detach $NVIDIA_GPU_AUDIO

```

```bash
/etc/libvirt/hooks/qemu.d/win11/release/end/revert.sh
--------------------------------------------------------------------------

NVIDIA_GPU_VIDEO=pci_0000_01_00_0
NVIDIA_GPU_AUDIO=pci_0000_01_00_1

# Bind the GPU to host
virsh nodedev-reattach $NVIDIA_GPU_VIDEO
virsh nodedev-reattach $NVIDIA_GPU_AUDIO

# Unload VFIO kernel modules
rmmod vfio_pci vfio_pci_core vfio_iommu_type1

# Load NVIDIA kernel modules
modprobe -i nvidia_modeset nvidia_uvm nvidia

```

Don't forget to make them executable:

```bash
sudo chmod +x /etc/libvirt/hooks/qemu.d/win11/prepare/begin/start.sh
```

```bash
sudo chmod +x /etc/libvirt/hooks/qemu.d/win11/release/end/revert.sh
```