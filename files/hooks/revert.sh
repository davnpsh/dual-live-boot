
NVIDIA_GPU_VIDEO=pci_0000_01_00_0
NVIDIA_GPU_AUDIO=pci_0000_01_00_1

# Bind the GPU to host
virsh nodedev-reattach $NVIDIA_GPU_VIDEO
virsh nodedev-reattach $NVIDIA_GPU_AUDIO

# Unload VFIO kernel modules
rmmod vfio_pci vfio_pci_core vfio_iommu_type1

# Load NVIDIA kernel modules
modprobe -i nvidia_modeset nvidia_uvm nvidia