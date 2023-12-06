NVIDIA_GPU_VIDEO=pci_0000_01_00_0
NVIDIA_GPU_AUDIO=pci_0000_01_00_1

# Unload NVIDIA kernel modules
rmmod nvidia_modeset nvidia_uvm nvidia

# Load VFIO kernel modules
modprobe -i vfio_pci vfio_pci_core vfio_iommu_type1

# Unbind the GPU from host
virsh nodedev-detach $NVIDIA_GPU_VIDEO
virsh nodedev-detach $NVIDIA_GPU_AUDIO