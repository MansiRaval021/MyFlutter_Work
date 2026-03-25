import 'dart:io';
void main()
{
  int m,s,space;
  for(m=1; m<=5; m++)
    {
      for(space=1; space<=5-m; space++){
        stdout.write(" ");
      }
      for(s=m; s>=1; s--)
      {

          stdout.write(s);

      }
      print(" ");
    }
}