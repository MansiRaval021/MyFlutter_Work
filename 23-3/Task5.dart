import 'dart:io';

void main()
{
  int row,col,space;
  for(row=1;row<=5;row++)
  {
    for(space=1;space<=5-row;space++)
    {
      stdout.write(" ");
    }
    for(col=1;col<=row;col++)
    {

      stdout.write("*");

    }
    print("");

  }
}