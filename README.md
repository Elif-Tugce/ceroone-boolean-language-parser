# CeroOne Boolean Language Parser

This project implements a parser for **CeroOne**, a simple programming language designed for processing Boolean data and Boolean lists.  
The parser is implemented using **Lex (Flex)** for lexical analysis and **Yacc (Bison)** for syntax analysis.

The project was developed as part of **CS315 – Programming Languages**.

## Language Overview

CeroOne is a minimal language focused on Boolean computation.  
It supports:

- Boolean values (`true`, `false`)
- Boolean lists (`bool*`, `bool**`)
- Logical expressions with clear operator precedence
- Functions with parameters and return values
- Conditional statements (`if`, `elif`, `else`)
- `switch` statements
- Loops (`while`, `for ... in`)
- Input and output operations
- List operations (`cons`, `head`, `tail`, `isEmpty`)
- Comments (`//` and `/* */`)

Programs consist of function definitions and top-level statements. Execution begins from the first top-level statement.

## Project Structure
