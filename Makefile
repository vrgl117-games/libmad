ROOTDIR = $(N64_INST)
CC = $(ROOTDIR)/bin/mips64-elf-gcc
AR = $(ROOTDIR)/bin/mips64-elf-ar
RANLIB = $(ROOTDIR)/bin/mips64-elf-ranlib
RM = rm -rf

libmad.a_OBJS = version.o fixed.o bit.o timer.o stream.o frame.o  \
	synth.o decoder.o layer12.o layer3.o huffman.o

INCS = -I. -I$(ROOTDIR)/include
CFLAGS = -march=vr4300 -mtune=vr4300 -O3 -G0 -Wall -g -D_GCC_LIMITS_H_ -DOPT_SPEED $(INCS)
CFLAGS += -DHAVE_SYS_TYPES_H -DHAVE_ERRNO_H -DHAVE_UNISTD_H -DHAVE_FCNTL_H -DWORDS_BIGENDIAN

all: $(libmad.a_OBJS) libmad.a

%.a: $(libmad.a_OBJS)
	$(RM) $@
	$(AR) cru $@ $($@_OBJS)
	$(RANLIB) $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	$(RM) *.o *.a

install: all
	cp mad.h $(ROOTDIR)/include
	cp libmad.a $(ROOTDIR)/lib
