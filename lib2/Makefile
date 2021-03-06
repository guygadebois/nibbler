#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: glourdel <glourdel@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2013/11/19 11:58:46 by glourdel          #+#    #+#              #
#    Updated: 2015/03/26 17:27:51 by glourdel         ###   ########.fr        #
#                                                                              #
#******************************************************************************#

##
#  This Makefile builds the second dynamic library for NIBBLER : lib2.so
#
#  Please note that we're forced to build SDL2 into a project's subfolders,
#  because of the security limitations of our school's dump, where we do not
#  have administrator's rights.
##


.PHONY: all a re clean fclean depend sources
.SUFFIXES:

include ../variables.mk

NAME = ../lib2.so


CFILES= \



SRCDIR = src/
SRC = $(addprefix $(SRCDIR),$(CFILES))

OBJDIR = obj/
OFILES = $(notdir $(CFILES:.cc=.o))
OBJ = $(addprefix $(OBJDIR),$(OFILES))

INCL_FLAGS = -I include -I ../include/ `SDL2/bin/sdl2-config --cflags`
FLAGS += -fPIC
CFLAGS = $(INCL_FLAGS) $(FLAGS)
LDFLAGS = -shared `SDL2/bin/sdl2-config --libs`

SDL2_VERSION = SDL2-2.0.3
SDL2_LINK = http://www.libsdl.org/release/$(SDL2_VERSION).tar.gz
SDL2_LIB = SDL2/lib/libSDL2.a

ifeq ($(shell uname), Linux)
	SDL2_DOWNLOAD_CMD = wget $(SDL2_LINK)
else
	SDL2_DOWNLOAD_CMD = curl $(SDL2_LINK) -o $(SDL2_VERSION).tar.gz
endif


all: SDL2 $(NAME)

a: all clean

SDL2: $(SDL2_LIB)

$(SDL2_LIB):
	@ mkdir -p SDL2/junk \
	&& $(SDL2_DOWNLOAD_CMD) \
	&& tar xf $(SDL2_VERSION).tar.gz \
	&& ( cd $(SDL2_VERSION) \
		&& ./configure --prefix=$(shell pwd)/SDL2/ \
		&& $(MAKE) && $(MAKE) install ) \
	&& mv $(SDL2_VERSION).tar.gz $(SDL2_VERSION) SDL2/junk \
	|| (echo $(RED)"ERROR: could not install SDL2."$(END) && rm -Rf SDL2)

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



