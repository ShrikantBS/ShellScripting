#!/bin/bash

read -p "Enter the first number: " num1
read -p "Enter the operation (+, -, *, /): " operand
read -p "Enter the second number: " num2

if [[ $operand == '+' ]]; then
    echo "The answer is $num1 + $num2 = $((num1 + num2))"

elif [[ $operand == '-' ]]; then
    echo "The answer is $num1 - $num2 = $((num1 - num2))"

elif [[ $operand == '*' ]]; then
    echo "The answer is $num1 * $num2 = $((num1 * num2))"

elif [[ $operand == '/' ]]; then
    # Check for division by zero
    if [[ $num2 -eq 0 ]]; then
        echo "Error: Division by zero is not allowed."
    else
        echo "The answer is $num1 / $num2 = $((num1 / num2))"
    fi

else
    echo "Inappropriate operand entered. Please enter a valid operand (+, -, *, /)."
fi


