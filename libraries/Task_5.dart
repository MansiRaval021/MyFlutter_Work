import 'dart:io';

void main() {
  print("Enter value of a:");
  double a = double.parse(stdin.readLineSync()!);

  print("Enter value of b:");
  double b = double.parse(stdin.readLineSync()!);

  double area = 0.5 * a * b;

  print("Area of Triangle = ");
  print(area);
}