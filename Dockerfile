FROM postgres:18.1-alpine3.23
LABEL maintainer="André Heuner"

RUN apk update && apk add postgresql18-contrib && rm -rf /var/cache/apk/*

RUN wget https://ftp.tu-chemnitz.de/pub/Local/urz/ding/de-en/de-en.txt.gz && gunzip de-en.txt.gz && \
    sed '/^#/d' de-en.txt | \
    sed 's/'\''/'\'''\''/g' | \
    sed 's/\s*::\s*/'\'','\'''/g | \
    sed 's/^\(.*\)$/INSERT INTO english.translation (german, english) VALUES ('\''\1'\'');/g' >/tmp/script-en.sql 
    
RUN wget https://raw.githubusercontent.com/zenogantner/ding-es-de/refs/heads/master/es-de && \
    sed '/^#/d' es-de | \
    sed 's/'\''/'\'''\''/g' | \
    sed 's/\s*\(::\s*\)\+/'\'','\'''/g | \
    sed 's/^\(.*\)$/INSERT INTO spanish.translation (spanish, german) VALUES ('\''\1'\'');/g' >/tmp/script-es.sql 
    
RUN rm de-en.txt && \
    chown postgres /tmp/script-en.sql && \
    chown postgres /tmp/script-es.sql

COPY init.sh /docker-entrypoint-initdb.d/
