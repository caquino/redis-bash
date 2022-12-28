clean:

install:
	install -d $(DESTDIR)/usr/share/redis-bash/
	install -d $(DESTDIR)/usr/bin
	install -v -m 755 redis-bash-cli $(DESTDIR)/usr/bin/
	install -v -m 644 redis-bash-lib $(DESTDIR)/usr/share/redis-bash/
	install -v -m 755 redis-pubsub-test ${DESTDIR}/usr/share/redis-bash/
