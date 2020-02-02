/*
 * ID3 tag version 2.4.
 */

#include <sys/types.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <ctype.h>

typedef unsigned char uchar;
typedef unsigned int uint;

typedef struct id3_tag Id3_tag;
typedef struct header Header;
typedef struct ex_header Ex_header;
typedef struct footer Footer;
typedef struct frame_header Frame_header;

/*
 * id3_tag flags
 */
#define ID3_ANALYZED      0x0001 /* id3_tag analyzed */
#define ID3_HAS_EX_HEADER 0x0002 /* id3_tag has extended header */
#define ID3_HAS_FOOTER    0x0004 /* id3_tag has footer */
#define ID3_HAS_PADDINGS  0x0008 /* id3_tag has padding */

/*
 * id3_tag header flags
 */
#define ID3_HDR_UNSYNCHRONISATION 0x80 /* Unsynchronisation applied */
#define ID3_HDR_EXTENDED_HEADER   0x40 /* Extended header following the header */
#define ID3_HDR_EXPERIMENTAL      0x20 /* Experimental indicator */
#define ID3_HDR_FOOTER            0x10 /* Footer exists */

/*
 * id3_tag footer flags
 */

/*
 * id3_tag frame flags
 */

struct id3_tag {
  uint flags;
  uint tag_size;
  
  int fd;
  char *fname;
  struct stat *stbuf;
  uchar *mmapped;

  Header *header;
  Ex_header *ex_header;
  int num_frames;
  uchar **framess;
  uchar *frames;
  uchar *paddings;
  Footer *footer;
};

struct header {
  char id[3];
  uchar version[2];
  uchar flags;
  uchar size[4];
};

struct ex_header {
  uint size;
  uchar num_of_flag_bytes;
  uchar extended_flags;
};

struct footer {
  char id[3];
  uchar version;
  uchar flags;
  uchar size[4];
};

struct frame_header {
  char id[4];
  uchar size[4];
  uchar flags;
};

/*
 *
 */
#define ERROR (-1)

/*
 * Function prototypes
 */

Id3_tag *id3_open(char *);
void id3_close(Id3_tag *);
void id3_info(Id3_tag);
void id3_header(Header *);
void id3_frame_header(Frame_header *);
int id3_analyze(Id3_tag *);

int get_number_of_frames(Id3_tag *);
void dump_memory(uchar *, int);
int get_size(uchar *);
int to_unsynchint(uint);
int msbtolsb(uchar *);
