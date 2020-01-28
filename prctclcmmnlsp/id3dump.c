/*
 * Dump ID3 format file
 */
#include <stdio.h>
#include <stdlib.h>

typedef struct header {
  char id[3]; /* "ID3" */
  unsigned char version[2];
  unsigned char flags[4];
  unsigned int size;
} Header;

typedef struct extended_header {
  unsigned int size;
  unsigned char num_of_flag_bytes;
  unsigned char extended_flags;
} Extended_header;
  
int
main(int argc, char *argv[])
{
  printf("Hello World\n");

  /*
   * Analyze options
   */

  /*
   * Open files
   */

  /*
   * Analyze the file
   */

  /*
   * Print out the contents of the file
   */

  /*
   * Close
   */
  
}
