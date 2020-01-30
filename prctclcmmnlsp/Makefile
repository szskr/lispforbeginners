#
# Simple Makefile
#
CFLAGS += -DDEBUG

HDR  = id3.h
OBJS = id3dump.o id3lib.o
PROG = id3dump

PCL = ./

all: $(PROG)

id3lib.o:  id3lib.c $(HDR)
	cc -c $(CFLAGS) id3lib.c

id3dump.o: id3dump.c $(HDR)
	cc -c $(CFLAGS) id3dump.c

$(PROG): $(OBJS)
	cc -o $(PROG) $(OBJS)

clean:
	rm -f $(PROG) $(OBJS)\
		$(PCL)/#*shell*# $(PCL)/*.fas  $(PCL)/*.fasl $(PCL)/*.lib \
		$(PCL)/data/ch14.03.txt $(PCL)/data/ch14.04.txt
