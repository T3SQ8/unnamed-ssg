CP = cp -f
RM = rm -f
LN = ln -sfr
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

link:
	mkdir -p $(DEST)
	$(LN) genindex $(DEST)
	$(LN) genrss $(DEST)
	$(LN) gentoc $(DEST)
	$(LN) mvfiles $(DEST)
	$(LN) ssg-build $(DEST)
	$(LN) wraphtml $(DEST)

.PHONY: install uninstall link
