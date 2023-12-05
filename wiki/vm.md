## Getting resources

In case you want your guest OS to be a Linux distro, you just have to go the official website and download the .iso via direct download or torrent. With Windows that isn't the case.

I highly recommend getting all your Windows related software from [massgrave.dev](https://massgrave.dev/genuine-installation-media.html).

For the Windows .iso I will be choosing Windows 11 from the [official links](https://www.microsoft.com/en-us/software-download).

If you ever need to activate Windows, just do it the **Microsoft Activation Scripts (MAS)** following this [tutorial](https://massgrave.dev/index.html#Method_1_-_PowerShell).

Also, we need **virtio** drivers for Windows. Download them [here](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-2/). Download the .iso version of the drivers and mount them as a SATA CDROM storage when creating the virtual machine.

## Creating a virtual machine

Open **Virtual Machine Manager** in your desktop and configure a new virtual machine using this [guide](https://gitlab.com/risingprismtv/single-gpu-passthrough/-/wikis/5\)-Configuring-Virtual-Machine-Manager) (I'm lazy to explain, but it is pretty easy).

### Configuration before install

In the **Overview** tab (make sure to enable XML editing), got to XML and delete these two lines under `<clock>`:

```
<timer name="rtc" tickpolicy="catchup"/>
<timer name="pit" tickpolicy="delay"/>
```

Then, change the present attribute of this line to **yes**:

```
<timer name="hpet" present="yes"/>
```

Also, make sure to have enabled the following in case of Windows 11:

* Q35 chipset

* UEFI (x64/OVMF_CODE.secboot.fd)

* TPM hardware
    * Emulated
    * v2.0
    * CRB model

For higher performance, make sure to have:

* Virtual disk bus (the one that Windows will be installed on) set to **virtio**.

* Network interface card model set to **virtio**.

## Installing Windows

You can now proceed to install Windows as normal.

### Empty drives list

If you encounter something like this during the install process:

<img src="https://gitlab.com/risingprismtv/single-gpu-passthrough/-/wikis/uploads/dfa4828fea018d3f441cc2566ab37fc0/Screenshot_win10-7.png" width="70%"/>

Just click on **Load driver** and then click **Ok**. A window with a drivers list should open. For Windows 11, you should select:

```
Red Hat VirtIO SCSI controller
```

If you find more than one with the same name, look for `amd64/w11/viostor.inf`.

### Windows local account

If you want a Windows local account instead of giving Microsoft your personal data do the following:

1. Turn off the VM and disconnect the **NIC** from the VM (delete it).
2. Start the VM, and when prompted for internet connection press `Shift` + `F10`, a cmd window should open. Type `oobe\bypassnro` and press Enter.
3. The VM should restart automatically and let you continue with a local account without Internet.
4. Turn off the VM and create another **NIC**.

### Virtio drivers

We also need virtio drivers. Go to the file explorer and you should see the CDROM for the virtio drivers. Open it and you should see at the bottom of files list a file called `virtio-win-guest-tools`. Execute it and go through the entire install process.