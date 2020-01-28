#
# Simple Makefile
#

OBJS = id3dump.o
PROG = id3dump

#PCL = prctclcmmlsp
PCL = ./

$(PROG): $(OBJS)
	cc -o $(PROG) $(OBJS)

clean:
	rm -f $(PROG) $(OBJS)\
		$(PCL)/#*shell*# $(PCL)/*.fas  $(PCL)/*.fasl $(PCL)/*.lib \
		$(PCL)/data/ch14.03.txt $(PCL)/data/ch14.04.txt
