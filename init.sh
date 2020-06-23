psql -v ON_ERROR_STOP=1 -o /dev/null --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL   
    CREATE DATABASE dictionaries;
    CREATE USER translator PASSWORD 'secret';
    GRANT ALL PRIVILEGES ON DATABASE dictionaries TO translator;

    \c dictionaries

    SET ROLE translator;
    
    CREATE SCHEMA english;
    CREATE SCHEMA spanish;
    
    CREATE SEQUENCE english.id_sequence START 1;
    CREATE SEQUENCE spanish.id_sequence START 1;
    
    CREATE TABLE english.translation (
      id      BIGINT PRIMARY KEY DEFAULT nextval('english.id_sequence'),
      german  VARCHAR(8192) NOT NULL,
      english VARCHAR(8192) NOT NULL
    );
    
    CREATE TABLE spanish.translation (
      id      BIGINT PRIMARY KEY DEFAULT nextval('spanish.id_sequence'),
      german  VARCHAR(8192) NOT NULL,
      spanish VARCHAR(8192) NOT NULL
    );
    
    \i /tmp/script-en.sql
    \i /tmp/script-es.sql
EOSQL

rm /tmp/script-en.sql
rm /tmp/script-es.sql
