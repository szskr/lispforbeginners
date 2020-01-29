/*
 * ID3 utility routines
 */

#include "./id3.h"

Id3_tag *
id3_open(char *fname)
{

  int fd;
  Id3_tag *id3_tag;
  Header *header;

  fd = open(fname, O_RDONLY, 0);
  if (fd == -1)
    return ((Id3_tag *) ERROR);

  header = (Header *) calloc(1, sizeof (struct header));
  if (header == (Header *) 0) {
    fprintf(stderr, "id3_open(): Could not allocate memory.");
    return ((Id3_tag *)ERROR);
  }

  /*
   * Simple sanity checks
   */
  if (read(fd, (char *)header, sizeof (struct header)) != (sizeof (struct header))) {
    fprintf(stderr, "id3_open(): Could not read header information from %s.\n", fname);
    free(header);
    close(fd);
    return ((Id3_tag *)ERROR);
  }

  if ((header->id[0] != 'I') ||
      (header->id[1] != 'D') ||
      (header->id[2] != '3')) {
    fprintf(stderr, "id3_open(): Illegal ID in %s.\n", fname);
    free(header);
    close(fd);
    return ((Id3_tag *)ERROR);
  }

  id3_tag = (Id3_tag *) calloc(1, sizeof (struct id3_tag));
  if (id3_tag == (Id3_tag *) 0) {
    fprintf(stderr, "id3_open(): Could not allocate memory.");
    free(header);
    close(fd);
    return ((Id3_tag *)ERROR);
  }

  id3_tag->fd = fd;
  id3_tag->fname = strdup(fname);
  if (id3_tag->fname == (char *)0) {
    fprintf(stderr, "id3_open(): Could not allocate memory.");
    free(header);
    close(fd);
    free(id3_tag);
    return ((Id3_tag *)ERROR);
  }
    
  free(header);
  return (id3_tag);
}
