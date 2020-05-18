FROM postgres:12.2-alpine

MAINTAINER André Heuner <andre.heuner@trinimon.de>

RUN wget https://ftp.tu-chemnitz.de/pub/Local/urz/ding/de-en/de-en.txt.gz && gunzip de-en.txt.gz && \
    sed '/^#/d' de-en.txt | \
    sed 's/'\''/'\'''\''/g' | \
    sed 's/\s*::\s*/'\'','\'''/g | \
    sed 's/^\(.*\)$/INSERT INTO english.dictionary VALUES ('\''\1'\'');/g' >/tmp/script-en.sql 
    
RUN wget http://cvs.savannah.nongnu.org/viewvc/*checkout*/ding-es-de/ding-es-de/es-de && \
    sed '/^#/d' es-de | \
    sed 's/'\''/'\'''\''/g' | \
    sed 's/\s*\(::\s*\)\+/'\'','\'''/g | \
    sed 's/^\(.*\)$/INSERT INTO spanish.dictionary VALUES ('\''\1'\'');/g' >/tmp/script-es.sql 
    
RUN rm de-en.txt && \
    chown postgres /tmp/script-en.sql && \
    chown postgres /tmp/script-es.sql

COPY init.sh /docker-entrypoint-initdb.d/
