#
# Simple Makefile
#
CFLAGS += -DDEBUG

HDR  = id3.h
OBJS = id3dump.o id3lib.o test.id3.01.o
PROGS = id3dump test.id3.01

PCL = ./

all: $(PROGS)

id3lib.o:  id3lib.c $(HDR)
	cc -c $(CFLAGS) id3lib.c

id3dump.o: id3dump.c $(HDR)
	cc -c $(CFLAGS) id3dump.c

test.id3.01.o: test.id3.01.c
	cc -c $(CLAGS) test.id3.01.c

id3dump: id3dump.o id3lib.o
	cc -o id3dump id3dump.o id3lib.o

test.id3.01: test.id3.01.o id3lib.o
	cc -o test.id3.01 test.id3.01.o id3lib.o

clean:
	rm -f $(PROGS) $(OBJS)\
		$(PCL)/#*shell*# $(PCL)/*.fas  $(PCL)/*.fasl $(PCL)/*.lib \
		$(PCL)/data/ch14.03.txt $(PCL)/data/ch14.04.txt
