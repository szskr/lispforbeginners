/*
 * ID3 utility routines
 */

#include "./id3.h"

/*
 * Open specified mp3 file and set up Id3_tag structure.
 */
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
    return ((Id3_tag *) ERROR);
  }

  if ((header->id[0] != 'I') ||
      (header->id[1] != 'D') ||
      (header->id[2] != '3')) {
    fprintf(stderr, "id3_open(): Illegal ID in %s.\n", fname);
    free(header);
    close(fd);
    return ((Id3_tag *)ERROR);
  }
  free(header);

  id3_tag = (Id3_tag *) calloc(1, sizeof (struct id3_tag));
  if (id3_tag == (Id3_tag *) 0) {
    fprintf(stderr, "id3_open(): Could not allocate memory.");
    close(fd);
    return ((Id3_tag *)ERROR);
  }

  id3_tag->fd = fd;
  id3_tag->fname = strdup(fname);
  if (id3_tag->fname == (char *)0) {
    fprintf(stderr, "id3_open(): Could not allocate memory.");
    close(fd);
    free(id3_tag);
    return ((Id3_tag *)ERROR);
  }

  id3_tag->stbuf = (struct stat *) calloc(1, sizeof (struct stat));
  if (id3_tag->stbuf == 0) {
    fprintf(stderr, "id3_open(): Could not allocate memory.");
    free(id3_tag->fname);
    close(fd);
    free(id3_tag);
    return ((Id3_tag *)ERROR);
  }

  if (fstat(fd, id3_tag->stbuf) < 0) {
    fprintf(stderr, "id3_open(): fstat():\n");
    free(id3_tag->fname);
    free(id3_tag->stbuf);
    close(fd);
    free(id3_tag);
    return ((Id3_tag *)ERROR);
  }

  id3_tag->mmapped = (uchar *) mmap(0, id3_tag->stbuf->st_size,
				    PROT_READ,
				    MAP_SHARED, fd, 0);
  if (id3_tag->mmapped == (uchar *) -1) {
    fprintf(stderr, "id3_open(): mmap():\n");
    free(id3_tag->fname);
    free(id3_tag->stbuf);
    close(fd);
    free(id3_tag);
    return ((Id3_tag *)ERROR);
  }
  id3_tag->header = (Header *)id3_tag->mmapped;
#ifdef DEBUG
  fprintf(stderr, "id3_open(%s): size = %d\n", fname, (int) id3_tag->stbuf->st_size);
#endif
  id3_tag->frames = id3_tag->mmapped + sizeof (struct header);
  
  return (id3_tag);
}

/*
 * Free specified ID3_tag
 */
void
id3_close(Id3_tag *id3_tag)
{
  close(id3_tag->fd);
  free(id3_tag->stbuf);
  free(id3_tag->fname);
  free(id3_tag);
}

/*
 * Dump ID3 header information
 */
void
id3_header(Header *h)
{
  printf("ID3 header\n");

  /*
   * Major/Minor version numbers
   */
  printf("\tMajor Version No        : %d\n", h->version[0]);
  printf("\tMinor Version No        : %d\n", h->version[1]);

  /*
   * Flags
   */
  printf("\tUnsynchronisation       : %s\n", (h->flags & 0x80) ? "ON"  : "OFF");
  printf("\tExtended Header         : %s\n", (h->flags & 0x40) ? "YES" : "NO");
  printf("\tExperimental indicator  : %s\n", (h->flags & 0x20) ? "ON"  : "OFF");
  printf("\tFooter present          : %s\n", (h->flags & 0x10) ? "YES" : "NO");

  /*
   * size
   */
  printf("\tSize                    : %d\n", get_size(h->size));
}

void
id3_frame_header(Frame_header *fh)
{
  int i;
  
  printf("ID3 frame header\n");

  printf("\tID: '");
  for (i = 0; i < 4; i++)
    printf("%c", fh->id[i]);
  printf("'\n");
  
  printf("\tSize                    : %d\n", get_size(fh->size));  
}

int
id3_analyze(Id3_tag *id3)
{
  if (id3->flags & ID3_ANALYZED)
    return (0);
  
  /*
   * Set id3 information
   */
  id3->header = (Header *) id3->mmapped;

  /*
   * Extended Header ?
   */
  if (id3->header->flags & 0x40)
    id3->ex_header = (Ex_header *) (id3->mmapped + sizeof (struct header));
  else
    id3->ex_header = (Ex_header *) NULL;

  /*
   * Footer ?
   */
  if (id3->header->flags & 0x10)
    id3->footer = (Footer *) (id3->mmapped + id3->stbuf->st_size - sizeof (struct footer));
  else
    id3->footer = (Footer *) NULL;

  /*
   * Padding
   */
  
  /*
   * Get number of frames
   */

  id3->flags |= ID3_ANALYZED;
  return (0);
}
