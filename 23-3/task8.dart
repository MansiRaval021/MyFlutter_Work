import 'dart:io';

void main() {
  int n = 3;

  for (int i = 1; i <= n; i++) {
    // print spaces
    for (int s = 1; s <= n - i; s++) {
      stdout.write(" ");
    }

    // print stars with space
    for (int j = 1; j <= i; j++) {
      stdout.write("* ");
    }

    print("");
  }
}