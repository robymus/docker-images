BACKEND_CDB ?= no
BACKEND_MYSQL ?= no
BACKEND_SQLITE ?= no
BACKEND_REDIS ?= no
BACKEND_POSTGRES ?= no
BACKEND_LDAP ?= no
BACKEND_HTTP ?= yes
BACKEND_JWT ?= no
BACKEND_MONGO ?= no
BACKEND_FILES ?= no
BACKEND_MEMCACHED ?= no
MOSQUITTO_SRC = /root/mosquitto
OPENSSLDIR = /usr
SUPPORT_DJANGO_HASHERS ?= no
CFG_LDFLAGS =
CFG_CFLAGS = -I$(MOSQUITTO_SRC) -ggdb -Wall -O2
