EXTENSION = pg_normalize_email
DATA = pg_normalize_email.sql
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
