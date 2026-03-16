//Write a program to make a square and cube of number.

import 'dart:io';

void main() {
  print("Enter a number:");
  int num = int.parse(stdin.readLineSync()!);

  int square = num * num;
  int cube = num * num * num;

  print("Square = ");
  print(square);

  print("Cube = ");
  print(cube);
}