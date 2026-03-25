import 'dart:io';

void main() {
  print("Enter marks of Subject 1:");
  double s1 = double.parse(stdin.readLineSync()!);

  print("Enter marks of Subject 2:");
  double s2 = double.parse(stdin.readLineSync()!);

  print("Enter marks of Subject 3:");
  double s3 = double.parse(stdin.readLineSync()!);

  print("Enter marks of Subject 4:");
  double s4 = double.parse(stdin.readLineSync()!);

  print("Enter marks of Subject 5:");
  double s5 = double.parse(stdin.readLineSync()!);

  double sum = s1 + s2 + s3 + s4 + s5;
  double percentage = sum / 5;

  print("Total Marks = ");
  print(sum);

  print("Percentage = ");
  print(percentage);
}