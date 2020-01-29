/*
 * ID3 tag version 2.4.
 */

#include <stdio.h>
#include <stdlib.h>

typedef unsigned char uchar;
typedef unsigned int uint;

typedef struct id3 Id3;
typedef struct header Header;
typedef struct extended_header Extended_header;
typedef struct footer Footer;

struct id3 {
  int fd;
  uchar *mmapped;
  Header *header;
  Extended_header *extended_header;
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

struct extended_header {
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
