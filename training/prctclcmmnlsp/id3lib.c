/*
 * ID3 utility routines
 */
#include "./id3.h"

static int get_frame_headers(Id3_tag *);

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

  header = (Header *) calloc(1, sizeof (Header));
  if (header == (Header *) 0) {
    printf("id3_open(): Could not allocate memory.");
    return ((Id3_tag *)ERROR);
  }

  /*
   * Simple sanity checks
   */
  if (read(fd, (char *)header, sizeof (Header)) != (sizeof (Header))) {
#ifdef DEBUG    
    d_printf("id3_open(): Could not read header information from %s.\n", fname);
#endif    
    free(header);
    close(fd);
    return ((Id3_tag *) ERROR);
  }

  if ((header->id[0] != 'I') ||
      (header->id[1] != 'D') ||
      (header->id[2] != '3')) {
#ifdef DEBUG    
    d_printf("id3_open(): Illegal ID in %s.\n", fname);
#endif    
    free(header);
    close(fd);
    return ((Id3_tag *)ERROR);
  }
  free(header);

  id3_tag = (Id3_tag *) calloc(1, sizeof (Id3_tag));
  if (id3_tag == (Id3_tag *) 0) {
#ifdef DBUG    
    d_printf("id3_open(): Could not allocate memory.");
#endif    
    close(fd);
    return ((Id3_tag *)ERROR);
  }

  id3_tag->fd = fd;
  id3_tag->fname = strdup(fname);
  if (id3_tag->fname == (char *)0) {
#ifdef DEBUG    
    d_printf("id3_open(): Could not allocate memory.");
#endif    
    close(fd);
    free(id3_tag);
    return ((Id3_tag *)ERROR);
  }

  id3_tag->stbuf = (struct stat *) calloc(1, sizeof (struct stat));
  if (id3_tag->stbuf == 0) {
#ifdef DEBUG    
    d_printf("id3_open(): Could not allocate memory.");
#endif    
    free(id3_tag->fname);
    close(fd);
    free(id3_tag);
    return ((Id3_tag *)ERROR);
  }

  if (fstat(fd, id3_tag->stbuf) < 0) {
    fprintf(stderr, "id3_open(): fstat():\n");
    free(id3_tag->fname);
    free(id3_tag->stbuf);
    free(id3_tag->frames);
    close(fd);
    free(id3_tag);
    return ((Id3_tag *)ERROR);
  }

  id3_tag->mmapped = (uchar *) mmap(0, id3_tag->stbuf->st_size,
				    PROT_READ,
				    MAP_SHARED, fd, 0);
  if (id3_tag->mmapped == (uchar *) -1) {
#ifdef DEBUG    
    d_printf("id3_open(): mmap():\n");
#endif    
    free(id3_tag->fname);
    free(id3_tag->stbuf);
    close(fd);
    free(id3_tag);
    return ((Id3_tag *)ERROR);
  }
  id3_tag->header = (Header *)id3_tag->mmapped;
  id3_tag->tag_size = get_size(id3_tag->header->size);

  if (id3_tag->header->flags & ID3_HDR_UNSYNCHRONISATION)
    id3_tag->flags |= ID3_UNSYNCHRONISATION;
  
  if (id3_tag->header->flags & ID3_HDR_EXTENDED_HEADER) {
    id3_tag->flags |= ID3_EXTENDED_HEADER;
    id3_tag->ex_header = (Ex_header *) (id3_tag->mmapped + sizeof (Header));
  }
  
  if (id3_tag->header->flags & ID3_HDR_EXPERIMENTAL)
    id3_tag->flags |= ID3_EXPERIMENTAL;
  
  if (id3_tag->header->flags & ID3_HDR_FOOTER) {
    id3_tag->flags |= ID3_FOOTER;
    id3_tag->footer = (Footer *) (id3_tag->mmapped + id3_tag->stbuf->st_size - sizeof (Footer));
  }
  
#ifdef DEBUG
  d_printf("id3_open(%s)\n", fname);
  d_printf("        : file_size = %d\n", (int) id3_tag->stbuf->st_size);
  d_printf("        : tag_size  = %d\n", (int) id3_tag->tag_size);
#endif

  /*
   * Get frame headers 
   */
  get_frame_headers(id3_tag);
 
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
  printf("\tUnsynchronisation       : %s\n", (h->flags & ID3_HDR_UNSYNCHRONISATION) ? "ON"  : "OFF");
  printf("\tExtended Header         : %s\n", (h->flags & ID3_HDR_EXTENDED_HEADER)   ? "YES" : "NO");
  printf("\tExperimental indicator  : %s\n", (h->flags & ID3_HDR_EXPERIMENTAL)      ? "ON"  : "OFF");
  printf("\tFooter present          : %s\n", (h->flags & ID3_HDR_FOOTER)            ? "YES" : "NO");

  /*
   * size
   */
  printf("\tSize                    : %d\n", get_size(h->size));
}

void
id3_frame_header(Frame_header *fh)
{
  int i;
  uchar *n_frame;
  
  printf("ID3 frame header:\n");

  printf("\tID: '");
  for (i = 0; i < 4; i++)
    printf("%c", fh->id[i]);
  printf("'\n");

  i = get_size(fh->size);
  printf("\tSize                    : %d\n", i);

  printf("\n");
  n_frame = (uchar *)fh + i + sizeof (Frame_header);
}

/*
 * Static functions
 */

static int
get_frame_headers(Id3_tag *id3_tag)
{
  int valid_header = TRUE;
  int free_slots = 0;
  uchar *limit = id3_tag->mmapped + id3_tag->stbuf->st_size;
  Frame_header *fh;
  static int frame_allocated = 0;
  Frame_header **fp = 0;

#ifdef DEBUG
  d_printf("get_frame_headers(): called\n");
#endif

  frame_allocated = sizeof (Frame_header *) * NUM_FRAME_ENTRIES_TO_ALLOCATE;
  id3_tag->frames = (Frame_header **) malloc(frame_allocated);
  free_slots = NUM_FRAME_ENTRIES_TO_ALLOCATE;

  fh = (Frame_header *) (id3_tag->mmapped + sizeof (Header));
  if (id3_tag->ex_header)
    fh += sizeof (Ex_header);

  while (valid_header &&
	 ((uchar *)fh < (uchar *) limit)) {
    /*
     * Check frame ID
     */
    int i;
    int size;
    uchar *end_of_frame;
    uchar *end_of_frame_header = (uchar *)fh + (sizeof (Frame_header));

    if (end_of_frame_header > limit) {
      valid_header = 0;
      break;
    }
    
    for (i = 0; i < 4; i++) 
      if (!((fh->id[i] >= 'A' && fh->id[i] <= 'Z') ||
	    (fh->id[i] >= '0' && fh->id[i] <= '9'))) {
	valid_header = 0;
#ifdef DEBUG
	d_printf("  Invalid first 4 bytes\n");
	dump_memory(fh, 10);
#endif
	break;
      }
    if (!valid_header)
      break;
    
    size = get_size(fh->size);
#ifdef DEBUG
    d_printf("  size of this frame = %d\n", size);
#endif
    end_of_frame = (uchar *)fh + sizeof (Frame_header) + size;
    
    if (end_of_frame > (uchar *)limit) {
      valid_header = 0;
      break;
    }
    
    /*
     * Ok, this is a valid frame.
     */
    if (free_slots == 0) {
      /*
       * reallocate memory
       */
#ifdef DEBUG      
      d_printf("    ** realloc!\n");
#endif      
      frame_allocated += sizeof (Frame_header *) * NUM_FRAME_ENTRIES_TO_ALLOCATE;
      fp = (Frame_header **) realloc(id3_tag->frames, frame_allocated);
      if (fp == NULL) {
	fprintf(stderr, "Could not allocate memory: realloc():\n");
	return (ERROR);
      }
      free_slots = NUM_FRAME_ENTRIES_TO_ALLOCATE;
    }
    id3_tag->frames[id3_tag->num_frames++] = fh;
    free_slots--;
    fh = (Frame_header *) end_of_frame;
  }
  
#ifdef DEBUG
  d_printf("  NUMBER of frames = %d\n", id3_tag->num_frames);
#endif
  return (OK);
}
