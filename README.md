# Flipping Bits in Assembly
This is an extension to my EFlags Status project in Assembly. Instead of simply showing the states of the Eflags, the colors of the 0's and 1's cycle through the rainbow with each change in state.

"Eflags" are the fundamental registers in Intel x86 microprocessors that contain the current state of the processor.

Each "flag" represents a state and lines up with each bit position, respectively:

- Sign Flag (SF): Indicates negative (0) or positive (1) state
- Zero Flag (ZF): Indicates a zero (1) or nonzero (0) state
- Adjust Flag (AF): Indicates an auxillary carry (1) or no auxillary carry
- Parity Flag (PF): Indicates an even (1) or odd (0) state
- Carry Flag (CF): Indicates an arithmetic borrow/carry (1) or no carry (0) While the Reserved (RES) remains the same for every operation.

This program was written in 981 lines of Assembly code using the MASM (Microsoft's Macro Assembler) in Visual Studio Code.
The [Irvine library](http://asmirvine.com/gettingStartedVS2017/index.htm) must be installed in the same directory in order for this to run properly.

![alt text](demo.png "Title")

