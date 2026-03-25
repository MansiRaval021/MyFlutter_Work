//2. Write a program to make addition, Subtraction, Multiplication and Division of
// Two Numbers.[User input]

import 'dart:io';

void main() {
  print("Enter first number:");
  int a = int.parse(stdin.readLineSync()!);

  print("Enter second number:");
  int b = int.parse(stdin.readLineSync()!);

  int add = a + b;
  int sub = a - b;
  int mul = a * b;
  double div = a / b;

  print("Addition = ");
  print(add);

  print("Subtraction = ");
  print(sub);

  print("Multiplication = ");
  print(mul);

  print("Division = ");
  print(div);
}