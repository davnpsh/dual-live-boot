## Blacklist nvidia_drm

It is necessary the blacklist the `nvidia_drm` module from loading since it doesn't let us unload it even if we don't any X11 session active. We don't need it to play games or use CUDA cores on the host anyways.

### Adding a configuration file

Create a new file called `no_nvidia_drm.conf` in the following path:


```
/etc/modprobe.d/no_nvidia_drm.conf
--------------------------------------------------------------------------
# Do not load the 'nvidia_drm' module on boot.
blacklist nvidia_drm

```

This way we don't need to edit GRUB just for blacklisting modules.

## NVIDIA PCI IDs

We need get to get the device IDs of the GPU itself and the audio. We can get those by running:

```bash
lspci -nnk | grep "NVIDIA"
```

In my case, this is the output:

```
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation TU117M [GeForce GTX 1650 Mobile / Max-Q] [10de:1f9d] (rev a1)
01:00.1 Audio device [0403]: NVIDIA Corporation Device [10de:10fa] (rev a1)
```

So the device IDs we are looking for are `10de:1f9d` and `10de:10fa`. I will use these for the rest of this section but you should use yours, so don't forget to replace them!

## Editing GRUB

You should find the grub configuration file for your system and edit the `GRUB_CMDLINE_LINUX_DEFAULT` line adding the following kernel parameters at the end of the previous ones:

```
/etc/default/grub
--------------------------------------------------------------------------
GRUB_CMDLINE_LINUX_DEFAULT="... nvidia_drm.modeset=1 intel_iommu=on vfio-pci.ids=10de:1f9d,10de:10fa"
```

Now, rebuild GRUB:

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```