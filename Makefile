CC = /home/utils/gcc-4.7.2/bin/gcc
AR = ar
CXX = /home/utils/gcc-4.7.2/bin/g++
CFLAGS = -g -O2
CXXFLAG =  -O2 -Wall -ggdb -m64 -D_GNU_SOURCE=1 -D_REENTRANT -D__GUNC__

ARCH:=$(shell uname -m)

ARCH32:=i686
ARCH64:=x86_64

ifeq ($(ARCH),$(ARCH64))
SYSTEM_LIB_PATH:=/usr/lib64
else
SYSTEM_LIB_PATH:=/usr/lib
endif

VPATH = .
DIRS=$(VPATH)

INC := $(INC)

LDFLAGS := $(LDFLAGS) -D_LINUX_OS_

CPP_SRCS = $(foreach dir, $(DIRS), $(wildcard $(dir)/*.cpp))
C_SRCS = $(foreach dir, $(DIRS), $(wildcard $(dir)/*.c))
OBJS = $(patsubst %.cpp,%.o,$(CPP_SRCS)) $(patsubst %.c,%.o,$(C_SRCS))


LIB = libCJsonObject.a

all: $(LIB)

$(LIB):$(OBJS)
	$(AR) cr $@ $(OBJS)
	mv $@ lib/

%.o:%.cpp
	$(CXX) $(INC) $(CXXFLAG) -c -o $@ $< $(LDFLAGS)
%.o:%.cc
	$(CXX) $(INC) $(CXXFLAG) -c -o $@ $< $(LDFLAGS)
%.o:%.c
	$(CC) $(INC) $(CXXFLAG) -c -o $@ $< $(LDFLAGS)
clean:
	rm -f $(OBJS)
	rm -f $(LIB)
	rm -rf lib/
