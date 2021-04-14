CP = cp -f
RM = rm -f
LN = ln -sfr
chmod = chmod 755
PREFIX =
DEST = $(DESTDIR)/usr/local/bin

install:
	mkdir -p $(DEST)
	$(CP) ssg-build $(DEST)

uninstall:
	$(RM) $(DEST)/ssg-build 

link:
	mkdir -p $(DEST)
	$(LN) ssg-build $(DEST)

.PHONY: install uninstall link
