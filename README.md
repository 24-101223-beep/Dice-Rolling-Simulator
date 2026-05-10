# Dice Rolling Simulator

A console-based dice rolling simulator written in C with
corresponding x86-64 Assembly code, built as part of a
Computer Architecture & Organization course project.

## Features
- Choose how many dice to roll
- Each die randomly generates a number between 1 and 6
- Displays the result of each individual die
- Displays the total sum of all dice
- Roll again option until the user decides to exit
- Input validation (rejects 0 or negative numbers)

## How to Run
1. Compile the C file:
   gcc Dice.c -o dice
2. Run:
   ./dice
3. Follow the on-screen prompts

## Project Files
- `Dice.c` — C source code
- `Dice.s` — x86-64 Assembly code
- `mapping (C-assembly).pdf` — mapping between C and Assembly instructions
- `flowchart.pdf` — register and flags trace flowchart
- `presentation - documentation slides.pptx` — project documentation

## Technologies
- Language: C and x86-64 Assembly
- Concepts: LCG random number generation,
  loops, input validation, register tracing
