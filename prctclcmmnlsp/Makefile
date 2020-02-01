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

id3util.o: id3util.c $(HDR)
	cc -c $(CFLAGS) id3util.c

id3lib.o:  id3lib.c $(HDR)
	cc -c $(CFLAGS) id3lib.c

id3dump.o: id3dump.c $(HDR)
	cc -c $(CFLAGS) id3dump.c

test.id3.01.o: test.id3.01.c
	cc -c $(CLAGS) test.id3.01.c

id3dump: id3dump.o $(ID3OBJS)
	cc -o id3dump id3dump.o $(ID3OBJS)

test.id3.01: test.id3.01.o $(ID3OBJS)
	cc -o test.id3.01 test.id3.01.o $(ID3OBJS)

clean:
	rm -f $(PROGS) *.o\
		$(PCL)/#*shell*# $(PCL)/*.fas  $(PCL)/*.fasl $(PCL)/*.lib \
		$(PCL)/data/ch14.03.txt $(PCL)/data/ch14.04.txt
