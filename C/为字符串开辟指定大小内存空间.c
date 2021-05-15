int strLength = 200;
char *str = (char *) malloc(strLength);
sprintf(str, "len %d", strLength);
free(strLength);