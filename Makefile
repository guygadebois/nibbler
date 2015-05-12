#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: glourdel <glourdel@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/03/26 17:28:27 by glourdel          #+#    #+#              #
#    Updated: 2015/05/12 13:50:31 by glourdel         ###   ########.fr        #
#                                                                              #
#******************************************************************************#

##
#  This Makefile is the main Makefile, that triggers all the sub-Makefiles.
#
#  It also provides targets to (re)generate the sub-Makefiles :
#    - use 'make generate' to generate sub-Makefiles WITHOUT building Nibbler.
#    - use 'make g' to generate sub-Makefile AND build Nibbler.
#
#  The Makefile generation consists in :
#    1) listing all *.cc in the source directory to create the CFILES variable.
#    2) for each source file, creating an individualized compilation rule.
#
#  The generation rule (either 'generate' or 'g') should be called in the
#  following cases :
#    - a source file has been ADDED to one of the source folders.
#    - a source file has been DELETED or RENAMED from one of the source folders.
#    - in an existing source file, an '#include' of a LOCAL HEADER has been
#    added or removed.
##


.PHONY: all re clean fclean g generate submodules cmake
.SUFFIXES:

include variables.mk


all:
	@make -C lib1
	@make -C lib2
	@make -C core

generate:
	@bash ./scripts/generate_all_makefiles;

g: generate re

fclean:
	@make -C core fclean
	@make -C lib1 fclean
	@make -C lib2 fclean

clean:
	@make -C core clean
	@make -C lib1 clean
	@make -C lib2 clean

re:	fclean all
