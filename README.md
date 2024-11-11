# ARM Cortex M0+ Assembly: 0/1 Knapsack Problem

This repository contains two assembly implementations of the 0/1 Knapsack problem for the ARM Cortex M0+ architecture. The two solutions provided are:

1. **Recursive Solution** (`recursive.s`): A recursive approach to solving the knapsack problem.
2. **Iterative Solution** (`iterative.s`): An iterative approach to solving the same problem.

## Project Overview

The 0/1 Knapsack problem is a classic optimization problem where, given a set of items with specific weights and values, the objective is to maximize the total value in a knapsack with a fixed weight capacity. Each item can either be included in the knapsack or excluded (hence, 0/1).

In this project, the algorithms are implemented in ARM Cortex M0+ assembly language, optimized for resource constraints typical of embedded systems.

### Assembly Implementation Details

- **Recursive Solution** (`recursive.s`): This file contains the assembly code for a recursive implementation of the 0/1 Knapsack algorithm. This approach may involve higher memory usage due to recursive calls and is designed to work within the limitations of ARM Cortex M0+.

- **Iterative Solution** (`iterative.s`): This file provides an iterative implementation, which uses a dynamic programming approach to solve the problem without recursion, making it generally more memory efficient and suitable for environments with limited stack space.

### Setup and Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/yahyayesilyurt/knapsack0-1-algorithm-with-assembly.git
   ```

2. Open each `.s` file (`recursive.s` or `iterative.s`) in your assembly development environment (e.g., Keil IDE).

3. Follow the comments within each file to set up input values and understand register usage, specifically noting that:
   - **Recursive solution** uses standard recursive calls with stack frame management.
   - **Iterative solution** uses a dynamic programming array where `R3` holds the base address of the `dp` array.

### Prerequisites

- **ARM Cortex M0+ Development Environment**: These assembly files are designed to be used with ARM Cortex M0+ and have been tested in the Keil IDE.
- **Basic Knowledge of ARM Assembly**: Understanding of ARM Cortex M0+ instruction set, memory addressing, and register usage is helpful.

## Project Structure

- `recursive.s`: Assembly code for the recursive solution.
- `iterative.s`: Assembly code for the iterative solution.
- `README.md`: Project description, setup, and usage instructions.
