//reverse number

import 'dart:io';

void main() {
  int reverse = 0;

  print("Enter Any Number");
  int num = int.parse(stdin.readLineSync().toString());//123

  while (num > 0) {
    int rem = num % 10;//123%10=3
    reverse = reverse * 10 + rem;//0=0*10+3 =3
    num = num ~/ 10;//123= 123 ~/10=12
  }

  print("Reversed number is : $reverse");//3
}

