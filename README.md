# The Knight's Calculator ♘

Welcome to **The Knight's Calculator**! This is a command-line calculator built using Swift that can evaluate arithmetic expressions, including those with parentheses and implicit multiplication (e.g., `5 + 10(6 + 1)`).

## Features

- Supports basic arithmetic operations: addition (`+`), subtraction (`-`), multiplication (`*`), and division (`/`).
- Handles expressions with parentheses (e.g., `(2 + 3) * 5`).
- Automatically inserts implicit multiplication where appropriate (e.g., `2(3 + 4)` is treated as `2 * (3 + 4)`).
- Validates input expressions before evaluating to ensure correctness.
- Provides continuous calculation until the user decides to exit the program.

## Project Structure

- **main.swift**: The main entry point of the program, containing the logic for parsing, validating, and evaluating arithmetic expressions.
- **Stack**: A simple generic stack implementation used for managing operators and parentheses during validation and conversion to postfix notation.
- **Validation Functions**: Ensure that input expressions are correctly formatted before evaluation.
- **Postfix Evaluation**: Uses the shunting-yard algorithm to convert infix expressions to postfix, then evaluates them using a stack.

## Setup

### Prerequisites

- Xcode 12 or later
- Swift 5.0 or later

### Installation

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/TheDarkNight21/the-knights-calculator.git
   cd knights-calculator
2.	Open the project in Xcode:
   open knights-calculator.xcodeproj
3.	Build and run the project using Xcode.

### Usage

	1.	Run the Program: Start the calculator by building and running the project in Xcode.
	2.	Input an Expression: The Knight’s Calculator will prompt you to enter an arithmetic expression.
	3.	View the Result: After entering a valid expression, the result will be displayed on the command line.
	4.	Continue or Exit: You can continue entering expressions or type exit to stop the calculator.

### How It Works

	1.	Validation: The calculator first checks if the expression is valid using a custom function that ensures balanced parentheses and correct operator placement.
	2.	Implicit Multiplication: It automatically adds multiplication where numbers are directly next to parentheses (e.g., 2(3) becomes 2 * (3)).
	3.	Infix to Postfix Conversion: The validated expression is converted into postfix notation using the shunting-yard algorithm.
	4.	Evaluation: The postfix expression is then evaluated using a stack to produce the result.

### Contributing

Contributions are welcome! If you have suggestions or find issues, feel free to open an issue or submit a pull request.

### License

This project is open-source and available under the MIT License. See the LICENSE file for more information.

### Acknowledgements

	•	Developed by Faris Allaf.
	•	Inspired by classic calculator designs and modern command-line tools.

👑 May your calculations be ever in your favor, with the wisdom of the Knight!
