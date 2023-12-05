## Adding GPU to VM

In the VM settings, you should add the hardware of your GPU, here is an example:

<img src="https://gitlab.com/risingprismtv/single-gpu-passthrough/-/wikis/images/vmm_pci_select.png" width="70%"/>

Make sure to add both the GPU and the audio device.

## NVIDIA/VFIO binding

To start the VM you should bind out GPU to VFIO kernel modules using these commands:

```bash
sudo rmmod nvidia_modeset nvidia_uvm nvidia
sudo modprobe -i vfio_pci vfio_pci_core vfio_iommu_type1
sudo virsh nodedev-detach pci_0000_01_00_0
sudo virsh nodedev-detach pci_0000_01_00_1
```

And whenever you stop using it, run these commands to bind you GPU again to the host:

```bash
sudo virsh nodedev-reattach pci_0000_01_00_0
sudo virsh nodedev-reattach pci_0000_01_00_1
sudo rmmod vfio_pci vfio_pci_core vfio_iommu_type1
sudo modprobe -i nvidia_modeset nvidia_uvm nvidia
```

Doing it manually is not comfortable, so I will be using hooks in the next section.

## Installing GPU drivers on the VM

Start your VM and inmediately install the necessary drivers for your GPU. You can do it with Windows Update or going to the NVIDIA official website and downloading drivers from there.

Now, turn off your VM, set the video Model to **None** and plug a monitor right into the HDMI port of your laptop. If you have luck, it should be connected directly to your GPU and display video.