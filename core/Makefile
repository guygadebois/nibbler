#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: glourdel <glourdel@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2013/11/19 11:58:46 by glourdel          #+#    #+#              #
#    Updated: 2015/03/26 17:37:09 by glourdel         ###   ########.fr        #
#                                                                              #
#******************************************************************************#

##
#  This Makefile builds the main executable for NIBBLER : 'nimbler'
##


.PHONY: all re clean fclean depend sources
.SUFFIXES:

include ../variables.mk

NAME = ../nimbler


CFILES= \



SRCDIR = src/
SRC = $(addprefix $(SRCDIR),$(CFILES))

OBJDIR = obj/
OFILES = $(notdir $(CFILES:.cc=.o))
OBJ = $(addprefix $(OBJDIR),$(OFILES))

INCL_FLAGS = -I include -I ../include
CFLAGS = $(INCL_FLAGS) $(FLAGS)
LDFLAGS =
ifeq ($(shell uname), Linux)
	LDFLAGS += -ldl
endif


all: $(NAME)

a: all clean

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



