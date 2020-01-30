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
    exit(1);
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
  id3_dump_header(id3_tag->header);
#ifdef DEBUG
  {
    int i = 0;
    char *p = (char *) id3_tag->mmapped + 10;
    for (i = 0; i < 4; i++)
      fprintf(stderr, "\ti[%d] = '%c'\n", i, *p++);
  }
#endif

  /*
   * Close
   */
  id3_close(id3_tag);
  
  exit(0);
}
