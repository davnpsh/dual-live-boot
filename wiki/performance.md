## CPU pinning

I won't explain it as I don't understand it fully yet and very few guides explain it, but you should read this [section](https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#CPU_pinning) of the Arch wiki.

My `lscpu -e` output:

```
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ      MHZ
  0    0      0    0 0:0:0:0          yes 4400.0000 400.0000 737.5180
  1    0      0    0 0:0:0:0          yes 4400.0000 400.0000 590.5360
  2    0      0    1 4:4:1:0          yes 4400.0000 400.0000 400.6460
  3    0      0    1 4:4:1:0          yes 4400.0000 400.0000 703.4580
  4    0      0    2 8:8:2:0          yes 4400.0000 400.0000 883.1090
  5    0      0    2 8:8:2:0          yes 4400.0000 400.0000 400.0000
  6    0      0    3 12:12:3:0        yes 4400.0000 400.0000 399.9260
  7    0      0    3 12:12:3:0        yes 4400.0000 400.0000 400.3780
  8    0      0    4 20:20:5:0        yes 3300.0000 400.0000 399.8390
  9    0      0    5 21:21:5:0        yes 3300.0000 400.0000 547.0840
 10    0      0    6 22:22:5:0        yes 3300.0000 400.0000 534.6420
 11    0      0    7 23:23:5:0        yes 3300.0000 400.0000 400.0000
```

My XML config:

```
  <vcpu placement="static">8</vcpu>
  <cputune>
    <vcpupin vcpu="0" cpuset="0"/>
    <vcpupin vcpu="1" cpuset="1"/>
    <vcpupin vcpu="2" cpuset="2"/>
    <vcpupin vcpu="3" cpuset="3"/>
    <vcpupin vcpu="4" cpuset="4"/>
    <vcpupin vcpu="5" cpuset="5"/>
    <vcpupin vcpu="6" cpuset="6"/>
    <vcpupin vcpu="7" cpuset="7"/>
    <emulatorpin cpuset="8"/>
  </cputune>
  <cpu mode="host-passthrough" check="none" migratable="on">
    <topology sockets="1" dies="1" cores="4" threads="2"/>
  </cpu>
```