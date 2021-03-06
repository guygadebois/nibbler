#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: glourdel <glourdel@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2013/11/19 11:58:46 by glourdel          #+#    #+#              #
#    Updated: 2015/05/12 13:43:37 by glourdel         ###   ########.fr        #
#                                                                              #
#******************************************************************************#

##
#  This Makefile builds the first dynamic library for NIBBLER : 'lib1.so'
#
#  Please note that on MacOS, we're forced to build cmake and SFML into
#  project's subfolders, because of the security limitations of our
#  school's dump, where we do not have administrator's rights.
##


.PHONY: all a re clean fclean depend sources
.SUFFIXES:

include ../variables.mk

NAME = ../lib1.so


CFILES= \



SRCDIR = src/
SRC = $(addprefix $(SRCDIR),$(CFILES))

OBJDIR = obj/
OFILES = $(notdir $(CFILES:.cc=.o))
OBJ = $(addprefix $(OBJDIR),$(OFILES))

INCL_FLAGS = -I include -I ../include/ -I SFML/include
FLAGS += -fPIC
CFLAGS = $(INCL_FLAGS) $(FLAGS)

BUILD_CMAKE_CMD =
ifeq ($(shell which cmake > /dev/null; echo $$?), 0)
	CMAKE = $(shell which cmake)
else
	# Build cmake into the 'cmake' project's subfolder
	CMAKE = $(shell pwd)/cmake/bin/cmake
	BUILD_CMAKE_CMD += git submodule init && git submodule update \
	  && ( cd cmake && ./bootstrap \
	    --prefix=$(pwd) && make && make install ) \
	    || echo $(RED)"ERROR: could not build cmake."$(END)
endif

LDFLAGS = -shared
BUILD_SFML_CMD =
ifeq ($(shell uname), Linux)
	# Rely on system's SFML, which has
	# to be installed with sudo apt-get install libsfml-dev.
	LDFLAGS += -lsfml-window
	LDFLAGS += -lsfml-audio
	LDFLAGS += -lsfml-graphics
	LDFLAGS += -lsfml-system
	LDFLAGS += -lsfml-network
	LDFLAGS += -lglut
else
	# Build SFML into the 'SFML' project's subfolder
	BUILD_SFML_CMD += @git submodule init && git submodule update \
	  && ( cd SFML && $(CMAKE) -D CMAKE_C_COMPILER:string="gcc" \
	    -D BUILD_SHARED_LIBS=FALSE . && make ) \
	  || echo $(RED)"ERROR: could not build SFML"$(END)

	LDFLAGS += -L SFML/lib
	LDFLAGS += -lsfml-window-s
	LDFLAGS += -lsfml-audio-s
	LDFLAGS += -lsfml-graphics-s
	LDFLAGS += -lsfml-system-s
	LDFLAGS += -lsfml-network-s
	LDFLAGS += -framework OpenGL -framework GLUT -framework Cocoa
	LDFLAGS += -framework CoreFoundation
	LDFLAGS += -framework ApplicationServices
	LDFLAGS += -framework CoreServices -framework Cocoa -framework Carbon
	LDFLAGS += -framework CoreAudio -framework OpenAL -framework CoreFoundation -framework ApplicationServices -framework OpenGL -framework IOKit -framework CoreServices -framework Cocoa -framework Carbon -L SFML/extlibs/libs-osx/lib -F SFML/extlibs/libs-osx/Frameworks/
	# LDFLAGS += -framework sndfile -framework freetype
endif


all: SFML $(NAME)

a: all clean

SFML: cmake
	$(BUILD_SFML_CMD)

cmake: $(CMAKE)

$(CMAKE):
	$(BUILD_CMAKE_CMD)

$(NAME): $(OBJ)
	@/bin/echo "";
	@echo $(BLUE)"    === Linking $@..."$(END);
	@/bin/echo "";
	@$(CXX) -o $(NAME) $(OBJ) $(CFLAGS) $(LDFLAGS)

fclean: clean
	@/bin/rm -f $(NAME)
	@echo $(BRED)"    === Removing "$(NAME)$(END)

clean:
	@/bin/rm -f $(OBJ)
	@echo $(RED)"    --> Removing .o files"$(END)

re:	fclean all



