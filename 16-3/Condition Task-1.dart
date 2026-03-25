import 'dart:io';

void main()
{
  int day;
  print("Enter Your (1 to 7):- ");
  day = int.parse(stdin.readLineSync().toString());

  switch(day) {
    case 1:
      print("Monday");
    case 2:
      print("Tuesday");
    case 3:
      print("Wednesday");
    case 4:
      print("Thursday");
    case 5:
      print("Friday");
    case 6:
      print("Saturday");
    case 7:
      print("Sunday");

    default:
      print("invalid input");
  }
  }