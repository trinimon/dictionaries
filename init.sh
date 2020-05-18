psql -v ON_ERROR_STOP=1 -o /dev/null --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL   
    CREATE DATABASE dictionaries;
    CREATE USER translator PASSWORD 'secret';
    GRANT ALL PRIVILEGES ON DATABASE dictionaries TO translator;

    \c dictionaries

    SET ROLE translator;
    
    CREATE SCHEMA english;

    CREATE TABLE english.dictionary (
      de VARCHAR(8192) NOT NULL,
      en VARCHAR(8192) NOT NULL
    );
    
    \i /tmp/script.sql
EOSQL

rm /tmp/script.sql
