clean:

install:
	install -d $(DESTDIR)/usr/share/redis-bash/
	install -d $(DESTDIR)/usr/bin
	install -v --mode=755 redis-bash-cli $(DESTDIR)/usr/bin/
	install -v --mode=644 redis-bash-lib $(DESTDIR)/usr/share/redis-bash/
