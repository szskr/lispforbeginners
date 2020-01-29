/*
 * Dump ID3 format file
 */

#include "./id3.h"
  
int
main(int argc, char *argv[])
{
  Id3_tag *id3_tag;
  char *fname;

  fname = argv[1];
  
  /*
   * Analyze options
   */
  if (argc < 2) {
    fprintf(stderr, "Usage: %s files,,,\n", argv[0]);
    exit (1);
  }

  /*
   * Open files
   */
  id3_tag = id3_open(fname);
  
  /*
   * Analyze the file
   */

  /*
   * Print out the contents of the file
   */

  /*
   * Close
   */
  id3_close(id3_tag);
}
