## The usual warning

**This wiki is for experienced Linux users. I am not responsible for any damages or breaks to your system if you don't know what you are doing.**

## Requirements

Before starting, you need to have:

* 2 or more GPUs (one of them can be a integrated GPU)
* At least 2 screens/monitors (but you can go through the entire guide with just one monitor and use your setup with Looking Glass)
* KDE Plasma on Wayland
* SDDM on Wayland

## My case:

I have an **NVIDIA Optimus** laptop with a NVIDIA dGPU and an Intel iGPU.

I will go through all this guide with the following goal in mind:

> Create a Windows 11 guest VM and passing my NVIDIA GPU to it.

I also tested these steps for Linux guests and it works.

## Preparations:

With this setup, the main goal is to use your GPU with your host and the guest OS, so you already need to have the drivers for your GPU installed on your host.

### BIOS settings

Make sure to **enable** the virtualisation settings for your motherboard:

| Intel CPU |
| - |
| VT-D |
| VT-X |

If you are like me and these options don't appear in the settings, just look for everything related to virtualisation and enable each option.

### SDDM on Wayland

By default, SDDM runs on X11, so it reclaims the NVIDIA GPU every time `sddm.service` starts. To avoid this, create a file called `10-wayland.conf` in `/etc/sddm.conf.d/` and put the following contents there:

```bash
/etc/sddm.conf.d/10-wayland.conf
--------------------------------------------------------------------------
[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_SHELL_INTEGRATION=layer-shell

[Wayland]
CompositorCommand=kwin_wayland --drm --no-lockscreen --no-global-shortcuts

```

SDDM on Wayland has some minor bugs but it's fine :).

### Avoid loading NVIDIA modules on Plasma session

Every time the Wayland compositor starts, some processes claim the NVIDIA GPU. To avoid this, add this environment variable in the following path (create the folder and file if they don't exist):


```bash
~/.config/environment.d/envvars.conf
--------------------------------------------------------------------------
__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json

```