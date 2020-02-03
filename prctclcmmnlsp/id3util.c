/*
 * ID3 utility routines
 */

#include "./id3.h"
/*
 * Utilities
 */

int
to_unsynchint(uint in)
{
  int out = 0;
  int mask = 0x7f000000;

  while (mask) {
    out >>= 1;
    out |= in & mask;
    mask >>= 8;
  }
  
  return (out);
}

int
msbtolsb(uchar *lsb)
{
  int idx = 0;
  union {
    char c[4];
    int i;
  } u;

  for (idx = 0; idx < 4; idx++) {
    fprintf(stderr, "val = 0x%x\n", *lsb);
    u.c[3 - idx] = *lsb++;
  }

  return (u.i);
}

int
get_size(uchar *s)
{
  int size = 0;
  size = (int) (*s++) << 21;
  size += (int) (*s++) << 14;
  size += (int) (*s++) << 7;
  size += (int) (*s);
  return (size);
}

void
dump_memory(uchar *s, int n)
{
  printf("DUMPing memory\n");

  while (n > 0) {
    if (isprint(*s))
	printf("\t0x%x = 0x%x|%c\n", s, *s, *s);
    else
	printf("\t0x%x = 0x%x\n", s, *s);	  
    s++;
    --n;
  }
}

void
d_printf(char *format, ...)
{
  va_list arg;
  
  va_start (arg, format);
  vfprintf(stderr, format, arg);
  va_end (arg);
}
