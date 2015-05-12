##
#  These two rules are included in every Makefile that can be generated by
#  'scripts/generate_makefile'.
#
#  Please see comments at the beginning of the main Makefile to know how
#  Makefile generation works.
##


sources:
	@echo $(IRED)"    Cleaning "$(SRCDIR)" content..."$(END)
	@find $(SRCDIR) -name "*~" -delete
	@find $(SRCDIR) -name "*#" -delete
	@find $(SRCDIR) -name "#*" -delete
	@find $(SRCDIR) -name ".#*" -delete
	@find $(SRCDIR) -name ".*.swp" -delete
	@echo 'CFILES= \\' > .sources
	@find $(SRCDIR) -name "*.cc" \
	  | sed 's/'"^[^\/]*\/"'/		/g' \
	  | sort \
	  | sed 's/.*/& \\/g' >> .sources
	@echo "" >> .sources

depend:
	@echo $(IGREEN)'Creating dependancies (.depend) \c';
	@rm -f .depend
	@echo '[\c'
	@$(foreach source,$(CFILES), echo '*\c'; \
	  echo $(OBJDIR)'\c' >> .depend; \
	  $(CXX) $(CFLAGS) -MM $(SRCDIR)$(source) >>  .depend; \
	  echo '\t@echo "\\033[32m    --> Creating' \
	    $(OBJDIR)$(notdir $(source:.cc=.o)) \
	    '...\\033[0m"' >>.depend; \
	  echo '\t@mkdir -p $$(OBJDIR);' >> .depend; \
	  echo '\t@$$(CXX) -o $$(OBJDIR)'$(notdir $(source:.cc=.o)) '\\' \
	    >> .depend; \
	  echo '-c -fPIC $$(SRCDIR)'$(source) '$$(CFLAGS)\n' >> .depend; \
	)
	@echo ']'$(END)