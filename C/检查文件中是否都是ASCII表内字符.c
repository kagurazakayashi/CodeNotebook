/*
KagurazakaYashi ASCII Checker
BUILD: gcc checkascii.c -o checkascii
USE  : ./checkascii <filepath> [-v]
       -v : be verbose
DEMO : ./checkascii index.html -v
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define DD "====="
#define OF "Open file"
int main(int argc, char *argv[]) {
  printf("%s ASCII Check %s\n", DD, DD);
  FILE *fp;
  int c;
  unsigned long yi = 0, ni = 0, ai = 0;
  if (argc >= 2) {
    char *fn = argv[1];
    short ve = 0;
    if (argc >= 3) {
      char *fv = argv[2];
      if (fv[0] == '-' && fv[1] == 'v') {
        ve = 1;
      }
    }
    printf("%s %s ...\n", OF, fn);
    fp = fopen(fn, "r");
    if (fp == NULL) {
      printf("%s %s failed!\n", OF, fn);
      exit(1);
    } else {
      printf("%s %s succeed.\n", OF, fn);
      printf("%s Ascii %s\n", DD, DD, fn);
      while ((c = fgetc(fp)) != EOF) {
        if (ve == 1)
          printf("%c(%i) ", c, c); // Display Information
        if (c > 177) {
          ni++;
          printf("\n[!!!] %lu: %c(%i)\n", ai, c, c);
        } else {
          yi++;
        }
        ai++;
      }
      printf("\n%s End %s\n   Ascii = %lu\nNo Ascii = %lu\n     All = %lu\n    "
             "File = %s\n",
             DD, DD, ai, ni, ai, fn);
    }
    fclose(fp);
  } else {
    printf("NO FILE!\n");
  }
  return 0;
}