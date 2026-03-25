//fibonacci -> 011235

import 'dart:io';

void main() {
  int n1 = 0, n2 = 1, n3;

  print("Enter number of terms:");
  int num = int.parse(stdin.readLineSync().toString());//5

  print("$n1");//0
  print("$n2");//1

  int i = 2;//3

  while (i < num) {//2<5 true "3 < 5 (true )"
    n3 = n1 + n2; //n3 = 0 +1 =1 " n3 = 1 + 1 =2"
    print("$n3"); //n3 = 1 " 2"

    n1 = n2; //0 = 1 "1"
    n2 = n3; //1 = 1 "2"

    i++;
  }
}