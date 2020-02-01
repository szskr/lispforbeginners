/*
 * test.id3.01.c
 */

#include "./id3.h"
  
int
main(int argc, char *argv[])
{
  int j;
  int ret;
  union {
    unsigned char c[4];
    int i;
  } u;

  u.c[0] = 0x00;
  u.c[1] = 0x05;
  u.c[2] = 0xeb;
  u.c[3] = 0x19;

  printf("Initial memory layout.\n");
  for (j = 0; j < 4; j++)
    printf("\tc[%d] = 0x%x\n", j, u.c[j]);
  printf(" i = 0x%x:%d\n", u.i, u.i);

  ret = to_unsynchint(msbtolsb(u.c));
  printf(" ret = 0x%x:%d\n", ret, ret);
  printf(" ret2= 0x%x:%d\n", get_size(u.c), get_size(u.c));
}
