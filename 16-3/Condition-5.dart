import 'dart:io';

void main()
{
  String uname = "Mansi";
  String pass = "232";

  print("Enter Your Username");
  var un = stdin.readLineSync().toString();
  print("Enter Your Password");
  var ps = stdin.readLineSync().toString();

  if(un==uname)
  {
    print("username is correct");
  }
  if(ps==pass)
  {
    print("password is correct");
  }


}