//Write a program to find the Area of Circle
import 'dart:io';

void main() {
  print("Enter radius of the circle:");
  double r = double.parse(stdin.readLineSync()!);

  double area = 3.14 * r * r;

  print("Area of Circle = ");
  print(area);
}