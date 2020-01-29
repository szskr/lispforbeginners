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

typedef unsigned char uchar;
typedef unsigned int uint;

typedef struct id3_tag Id3_tag;
typedef struct header Header;
typedef struct ex_header Ex_header;
typedef struct footer Footer;

struct id3_tag {
  int fd;
  struct stat *stbuf;
  char *fname;
  uchar *mmapped;
  Header *header;
  Ex_header *ex_header;
  uchar *frames;
  uchar *paddings;
  Footer *footer;
};

struct header {
  char id[3];
  uchar version[2];
  uchar flags;
  uint size;
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
  uint size;
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
