#
# Simple Makefile
#
CFLAGS += -DDEBUG

HDR  = id3.h
ID3OBJS = id3lib.o id3util.o 
ID3OBJS = id3lib.o id3util.o 
PROGS = id3dump test.id3.01
PCL = ./

all: $(PROGS)

%.o: %.c $(HDR)
	$(CC) -c $(CFLAGS) -o $@ $<

id3dump: id3dump.o $(ID3OBJS)
	$(CC) -o id3dump id3dump.o $(ID3OBJS)

test.id3.01: test.id3.01.o $(ID3OBJS)
	$(CC) -o test.id3.01 test.id3.01.o $(ID3OBJS)

clean:
	rm -f $(PROGS) *.o\
		$(PCL)/#*shell*# $(PCL)/*.fas  $(PCL)/*.fasl $(PCL)/*.lib \
		$(PCL)/data/ch14.03.txt $(PCL)/data/ch14.04.txt
