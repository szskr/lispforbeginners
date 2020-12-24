/*
 * Dump ID3 format file
 */

#include "./id3.h"
  
int
main(int argc, char *argv[])
{
  Id3_tag *id3_tag;
  char *fname;
  int i;

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
   * Print out the contents of the file
   */
  id3_header(id3_tag->header);

  for (i = 0; i < id3_tag->num_frames; i++)
    id3_frame_header((Frame_header *) id3_tag->frames[i]);

  /*
   * Close
   */
  id3_close(id3_tag);
  
  exit(0);
}
