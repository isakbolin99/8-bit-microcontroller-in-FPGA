# 8-bit microprocessor in FPGA

## Description
In this project, I designed an 8-bit microprocessor in the Altera DE1 SoC FPGA board (see figure below).

![Board](images/de1soc.jpg)

The microcontroller with its main components, peripherals, and registers are displayed in the two figures below.

![System](images/8bitmicroprocessorsystem.jpg)
![System](images/blockschematicchanged.jpg)

With the software Quartus Prime, each system component was built with its .vhd file. The final system's block diagram can be seen below.

![System](images/blockquartus.jpg)

## Usage
To use this project, install Quartus Prime 18.1 Lite and upload all the .vhd files to your project. The whole project can be simulated in the software if you don't have access to the Altera board.
