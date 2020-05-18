FROM postgres:12.2-alpine

MAINTAINER André Heuner <andre.heuner@trinimon.de>

RUN wget https://ftp.tu-chemnitz.de/pub/Local/urz/ding/de-en/de-en.txt.gz && gunzip de-en.txt.gz && \
    sed '/^#/d' de-en.txt | \
    sed 's/'\''/'\'''\''/g' | \
    sed 's/\s*::\s*/'\'','\'''/g | \
    sed 's/^\(.*\)$/INSERT INTO english.dictionary VALUES ('\''\1'\'');/g' >/tmp/script.sql 
    
RUN rm de-en.txt && \
    chown postgres /tmp/script.sql

COPY init.sh /docker-entrypoint-initdb.d/
