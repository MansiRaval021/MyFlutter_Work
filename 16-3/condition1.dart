import 'dart:io';

void main ()
{
  int marks;
  print("Enter your marks ");
  marks = int.parse(stdin.readLineSync().toString());

  if(marks>=35)
    {
      print("Pass");
    }
    else
      {
        print("Fail");
      }
}