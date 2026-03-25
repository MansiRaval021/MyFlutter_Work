import 'dart:io';

void main() {


  print("Enter value of a :- ");
  int a = int.parse(stdin.readLineSync().toString());

  print("Enter value of b :- ");
  int b = int.parse(stdin.readLineSync().toString());

  print("Choose operation (+, -, *, /):");
  String op = stdin.readLineSync();
  switch(op){
  case 1:
    print("addition:-");
    (a+b);

}
}

