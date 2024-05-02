# ALU-System
- This repository contains Verilog code for various modules used in a computer system. Each module serves a specific purpose and is interconnected to form a functional computer system.

## Modules

Here's a README file for your Verilog code:

Verilog Code Overview
This repository contains Verilog code for various modules used in a computer system. Each module serves a specific purpose and is interconnected to form a functional computer system.

Modules
1. Register Module (Register.v)
This module implements a generic register with configurable functionalities such as decrement, increment, load, clear, write low, write high, and sign extension.

2. Register File (RegisterFile.v)
The Register File module acts as a collection of registers and scratch registers. It allows reading from and writing to specific registers based on control signals.

3. Instruction Register (InstructionRegister.v)
This module implements an Instruction Register that stores instruction data and can load data into appropriate bytes during write operations.

4. Address Register File (AddressRegisterFile.v)
The Address Register File module manages address-related operations, including reading from and writing to specific address registers.

5. Arithmetic Logic Unit (ArithmeticLogicUnit.v)
The Arithmetic Logic Unit (ALU) performs arithmetic and logical operations based on control signals and input data.

6. Arithmetic Logic Unit System (ArithmeticLogicUnitSystem.v)
This top-level module integrates the aforementioned modules to create a functioning Arithmetic Logic Unit (ALU) system.

## Usage
- Clone the repository to your local machine.
- Open the Verilog files in a compatible simulation or synthesis tool.
- Simulate or synthesize the modules based on your requirements.

## Notes
- Ensure that all modules are correctly interconnected and that control signals are appropriately configured for desired operations.
- Verify timing constraints and ensure compatibility with your target platform.
