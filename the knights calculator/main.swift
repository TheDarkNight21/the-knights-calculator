//
//  main.swift
//  the knights calculator
//
//  Created by Faris Allaf on 10/18/24.
//

import Foundation

print("Hello, my name is Knight and welcome to the Knight's Calculator!" +
      "\nPlease enter your expression and let the Knight handle the rest!")

// Implementation of a generic stack to handle various types.
struct Stack<T> {
    private var array: [T] = []

    mutating func push(_ element: T) {
        array.append(element)
    }

    mutating func pop() -> T? {
        return array.popLast()
    }

    func peek() -> T? {
        return array.last
    }

    func isEmpty() -> Bool {
        return array.isEmpty
    }
}

// Function to get the precedence of operators.
func precedence(of operator: String) -> Int {
    switch `operator` {
    case "+", "-":
        return 1
    case "*", "/":
        return 2
    default:
        return 0
    }
}

// Convert infix expression to postfix using the shunting-yard algorithm.
func infixToPostfix(_ input: String) -> [String] {
    var output = [String]()
    var operatorStack = Stack<String>()
    var i = 0
    let tokens = Array(input)

    while i < tokens.count {
        let token = tokens[i]

        if token.isNumber {
            var number = ""
            while i < tokens.count, tokens[i].isNumber {
                number.append(tokens[i])
                i += 1
            }
            output.append(number)
            continue
        } else if token == "(" {
            operatorStack.push(String(token))
        } else if token == ")" {
            while let top = operatorStack.peek(), top != "(" {
                output.append(operatorStack.pop()!)
            }
            operatorStack.pop() // Remove the '(' from the stack
        } else if "+-*/".contains(token) {
            let currentOp = String(token)
            while let topOp = operatorStack.peek(), precedence(of: topOp) >= precedence(of: currentOp) {
                output.append(operatorStack.pop()!)
            }
            operatorStack.push(currentOp)
        }

        i += 1
    }

    // Pop remaining operators to the output.
    while !operatorStack.isEmpty() {
        output.append(operatorStack.pop()!)
    }

    return output
}

// Evaluate the postfix expression.
func evaluatePostfix(_ postfix: [String]) -> Int {
    var stack = Stack<Int>()
    
    for element in postfix {
        if let number = Int(element) {
            stack.push(number)
        } else {
            // Assume element is an operator.
            guard let right = stack.pop(), let left = stack.pop() else {
                fatalError("Invalid postfix expression")
            }
            
            let result: Int
            switch element {
            case "+":
                result = left + right
            case "-":
                result = left - right
            case "*":
                result = left * right
            case "/":
                result = left / right
            default:
                fatalError("Unsupported operator \(element)")
            }
            stack.push(result)
        }
    }

    return stack.pop() ?? 0
}

// Handle implicit multiplication in the input.
func formatInputForImplicitMultiplication(_ input: String) -> String {
    var formattedInput = ""
    let chars = Array(input)
    
    for i in 0..<chars.count {
        formattedInput.append(chars[i])
        
        if i < chars.count - 1 {
            let current = chars[i]
            let next = chars[i + 1]
            
            if (current.isNumber && next == "(") || (current == ")" && next.isNumber) || (current == ")" && next == "(") {
                formattedInput.append("*")
            }
        }
    }
    
    return formattedInput
}

// Validate the input expression and extract numbers and operators if valid.
func isValid(_ input: String) -> (Bool, [String], [String]) {
    let formattedInput = formatInputForImplicitMultiplication(input)
    let operators = "+-/*"
    let chars = Array(formattedInput)
    var numbers = [String]()
    var operatorsInExpression = [String]()
    var stack = Stack<Character>()

    if !validateParentheses(chars, with: &stack) {
        return (false, numbers, operatorsInExpression)
    }

    (numbers, operatorsInExpression) = extractNumbersAndOperators(from: formattedInput, using: operators)

    // Check if the number of operators is equal to numbers - 1.
    if numbers.count - 1 != operatorsInExpression.count {
        return (false, numbers, operatorsInExpression)
    }

    return (true, numbers, operatorsInExpression)
}

// Check for valid parentheses using a stack.
func validateParentheses(_ chars: [Character], with stack: inout Stack<Character>) -> Bool {
    for char in chars {
        if char == "(" {
            stack.push(char)
        } else if char == ")" {
            if stack.isEmpty() {
                return false
            }
            stack.pop()
        }
    }
    return stack.isEmpty()
}

// Extract numbers and operators from the input string.
func extractNumbersAndOperators(from input: String, using operators: String) -> ([String], [String]) {
    let expression = input.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
    let separators = CharacterSet(charactersIn: operators)
    let numbers = expression.components(separatedBy: separators).filter { !$0.isEmpty }
    let operatorsInExpression = expression.filter { operators.contains($0) }.map { String($0) }

    return (numbers, operatorsInExpression)
}

// Execute the calculation by converting infix to postfix and evaluating it.
func executeCalculation(_ input: String) {
    let formattedInput = formatInputForImplicitMultiplication(input)
    let postfix = infixToPostfix(formattedInput)
    let result = evaluatePostfix(postfix)
    print("Result: \(result)")
}

// Main loop to keep the calculator running.
func startCalculator() {
    while true {
        print("\nEnter an expression to calculate, or type 'exit' to quit:")
        guard let input = readLine(), input.lowercased() != "exit" else {
            print("Thank you for using the Knight's Calculator! Keep your King Safe! \u{1F451}")
            break
        }
        
        let (isValidExpression, numbers, operatorsInExpression) = isValid(input)
        
        if isValidExpression {
//            print("The expression is valid.")
//            print("Numbers: \(numbers)")
//            print("Operators: \(operatorsInExpression)")
            executeCalculation(input)
        } else {
            print("The expression is invalid. Please check your input and try again \u{265E}")
        }
    }
}

// Start the calculator.
startCalculator()
