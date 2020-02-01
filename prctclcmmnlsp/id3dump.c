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
#ifdef DEBUG
  dump_memory(id3_tag->mmapped, sizeof (struct header));
#endif
  
  /*
   * Analyze the file
   */

  /*
   * Print out the contents of the file
   */
  id3_header(id3_tag->header);
  id3_frame_header((Frame_header *) id3_tag->frames);

  /*
   * Close
   */
  id3_close(id3_tag);
  
  exit(0);
}
