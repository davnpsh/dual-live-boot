# Dual (live) boot (for NVIDIA Optimus)

> A guide about how to setup QEMU/KVM for passing resources from a Linux host to a VM guest.

This repository serves as documentation for my setup process. This may also help someone with similar hardware/problems.

To start, go to the [wiki](https://github.com/davnpsh/dual-live-boot/wiki/1\)-Requirements).

## Who is this guide for?

<img src="./imgs/based_pepe.png" width="30%" align="right"/>

This is a setup ideal for **NVIDIA Optimus** laptops and/or for people with multiple GPUs (one of them being NVIDIA) on their systems and want to dual boot two operating systems at the same time without having to restart or kill the current desktop session.

I use Arch Linux (btw), but in theory this setup should be possible in Debian-based distros, Fedora, etc. with some differences (secure boot, package names, ...).

## Why? (just stick to windows lol)

I don't want to install spyware. It looks (and runs) better on virtualized environments. Also, I don't want to reboot every time I need to run a single program/game.

<img src="./imgs/reboot_not_required.jpg" width="40%"/>

## Credits

I was inspired to make this documentation by reading the [Risingprism's guide](https://gitlab.com/risingprismtv/single-gpu-passthrough).

Most of this setup is thanks to Steve's effort on making a [seamless VFIO switching](https://www.youtube.com/watch?v=LtgEUfpRbZA&t=1s) with a similar setup.

<hr>

<div align="center">

![](./imgs/archlinux.gif)
![](./imgs/nvidia.gif)

</div>