import 'dart:io';
void main()
{
  //Pi*r*r

  var PI = 3.14;
  
  print("Emter Your Radius");
  var r = int.parse(stdin.readLineSync().toString());
  //for type casting we are using int.parse that will convert string value to ineteger

  var ans = PI*r*r;
  print(ans);
}