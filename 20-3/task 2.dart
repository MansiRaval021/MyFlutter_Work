//factorial -> 5! -> 5*4*3*2*1

import 'dart:io';

void main() {
  int fact = 1;

  print("Enter Any Number");
  int num = int.parse(stdin.readLineSync().toString());//4

  for (int i = 1; i <= num; i++) {
    fact = fact * i; //6 = 6 * 4= 24
  }

  print("Factorial is : $fact");
}