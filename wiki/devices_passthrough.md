## Passing keyboard/mouse via Evdev

Edit the XML config file for your VM and add the following:

```
  <devices>
    ...
    <input type='evdev'>
      <source dev='/dev/input/by-id/MOUSE_NAME'/>
    </input>
    <input type='evdev'>
      <source dev='/dev/input/by-id/KEYBOARD_NAME' grab='all' repeat='on' grabToggle='ctrl-ctrl'/>
    </input>
    ...
  </devices>
```

To get `MOUSE_NAME` and `KEYBOARD_NAME` list all the files in the directory:

```bash
ls /dev/input/by-id/
```

From the list, look for the mouse and keyboard names that end with `-event-mouse` and `-event-kbd`.

To switch the control between the host and the guest just press both `Ctrl` keys (it doesn't have to be at the same time).

Consider adding these virtio devices as well:

```
...
<input type='mouse' bus='virtio'/>
<input type='keyboard' bus='virtio'/>
...
```