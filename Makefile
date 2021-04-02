CP = cp -f
RM = rm -f
chmod = chmod 755
PREFIX =
DEST = $(DESTDIR)/usr/local/bin

install:
	mkdir -p $(DEST)
	$(CP) genindex $(DEST)
	$(CP) genrss $(DEST)
	$(CP) gentoc $(DEST)
	$(CP) mvfiles $(DEST)
	$(CP) ssg-build $(DEST)
	$(CP) wraphtml $(DEST)

uninstall:
	$(RM) $(DEST)/genindex 
	$(RM) $(DEST)/genrss 
	$(RM) $(DEST)/gentoc 
	$(RM) $(DEST)/mvfiles 
	$(RM) $(DEST)/ssg-build 
	$(RM) $(DEST)/wraphtml 
