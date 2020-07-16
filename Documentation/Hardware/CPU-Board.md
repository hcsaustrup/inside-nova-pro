# CPU Board

## Introduction

The system is based around the i.MX6UL SoM by Chinese company Forlinx. We refer to that as the *CPU Board*. It features a Arm® Cortex®-A7 processor as well as RAM and NVRAM. The CPU Board is mounted on another board, which we call the [I/O Board](IO-Board.md). 

## Versions

### Quick Overview

 | &nbsp; | Type A (Y001) | Type B (Y005)              |
 | ------ | ------------- | -------------------------- |
 | CPU    | i.MX6ULL      | i.MX6ULL                   |
 | DRAM   | 512 MiB       | 256 MiB                    |
 | NVRAM  | 8 GiB         | 8 GiB                      |
 | Notes  |               | Covered by metal RF shield |

The names *Type A* and *Type B* are temporary and subject to change. It's not known if these CPU boards are interchangable.

### Type A (Y001)

* CPU: Freescale [i.MX6ULL](https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i.mx-applications-processors/i.mx-6-processors/i.mx-6ull-single-core-processor-with-arm-cortex-a7-core:i.MX6ULL) 396MHz ([MCIMX6G2CVM05AA](https://www.nxp.com/part/MCIMX6G2CVM05AA#/)) (Includes Ethernet)
* DRAM: 512 MiB RAM (Nanya 1714 NT5CC256M160P-01)
* NVRAM: 8 GiB eMMC ([THGBMFG6C1LBAIL](https://eu.mouser.com/ProductDetail/Kioxia-America/THGBMFG6C1LBAIL?qs=hicmRmzGcNTKfLV%252BlObBrg==))


### Type B (Y005)

This appears to be the latest version of the CPU boards NOVA uses. It's slightly faster, but lacks memory compared to the previous version. The CPU board on the Y005 model is covered entirely by a metal RF shield.

* CPU: Freescale [i.MX6ULL](https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i.mx-applications-processors/i.mx-6-processors/i.mx-6ull-single-core-processor-with-arm-cortex-a7-core:i.MX6ULL) 528 MHz ([MCIMX6G2CVM05AA](https://www.nxp.com/part/MCIMX6G2CVM05AA#/)) (Includes Ethernet)
* DRAM: 256 MiB RAM
* NVRAM: 8 GiB eMMC


## Resources
 
* [Forlinx iMX6UL Hardware Manual V1.5](../Assets/PDF/iMX6UL-HardwareManual-V1.5.pdf) (Mirror)


