//
//  main.swift
//  calculator
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

// Validate the input expression and extract numbers and operators if valid.
func isValid(_ input: String) -> (Bool, [String], [String]) {
    let operators = "+-/*"
    let chars = Array(input)
    var numbers = [String]()
    var operatorsInExpression = [String]()
    var stack = Stack<Character>()

    if !validateParentheses(chars, with: &stack) {
        return (false, numbers, operatorsInExpression)
    }

    (numbers, operatorsInExpression) = extractNumbersAndOperators(from: input, using: operators)

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
    let numbers = expression.components(separatedBy: separators)
    let operatorsInExpression = expression.filter { operators.contains($0) }.map { String($0) }

    return (numbers, operatorsInExpression)
}

// Get user input and validate the expression.
guard let input = readLine() else {
    print("Invalid input.")
    exit(0)
}

let (isValidExpression, numbers, operatorsInExpression) = isValid(input)

if isValidExpression {
    print("The expression is valid.")
    print("Numbers: \(numbers)")
    print("Operators: \(operatorsInExpression)")
} else {
    print("The expression is invalid. Please check your input.")
}
