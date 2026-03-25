import 'dart:io';
void main()
{
  for(int m = 1; m<=5; m++)
    {
      for(int s=1; s<=m; s++)
        {
          if((m+s)% 2 == 0) {
            stdout.write("1");
          }
          else{
            stdout.write("0");
          }
        }
      print(" ");
    }
}