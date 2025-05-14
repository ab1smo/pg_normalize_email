EXTENSION    = pg_normalize_email
EXTVERSION   = $(shell grep default_version $(EXTENSION).control | sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")

DATA         = $(wildcard sql/*--*.sql)
DOCS         = README.md
PG_CONFIG    = pg_config

DIST_ARCHIVE = $(EXTENSION)-$(EXTVERSION).tar.gz
DIST_FILES   = $(wildcard *.control) $(wildcard sql/*.sql) README.md Makefile META.json

dist:
	 tar -czf $(DIST_ARCHIVE) $(DIST_FILES)

PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
