import 'dart:io';

void main() {
  print("Enter Principal (P):");
  double p = double.parse(stdin.readLineSync()!);

  print("Enter Rate (R):");
  double r = double.parse(stdin.readLineSync()!);

  print("Enter Time (N):");
  double n = double.parse(stdin.readLineSync()!);

  double interest = (p * r * n) / 100;

  print("Simple Interest = ");
  print(interest);
}