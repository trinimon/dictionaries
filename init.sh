psql -v ON_ERROR_STOP=1 -o /dev/null --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL   
    CREATE DATABASE dictionaries;
    CREATE USER $TRANSLATOR_USER PASSWORD '$TRANSLATOR_PASSWORD';
    GRANT ALL PRIVILEGES ON DATABASE dictionaries TO $TRANSLATOR_USER;

    \c dictionaries

    SET ROLE translator;

    CREATE EXTENSION IF NOT EXISTS pg_trgm;
    
    CREATE SCHEMA english;
    CREATE SCHEMA spanish;
    CREATE SCHEMA common;
    
    CREATE SEQUENCE english.id_sequence START 1000000;
    CREATE SEQUENCE spanish.id_sequence START 2000000;
    
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

    CREATE INDEX translation_english_idx ON english.translation USING gin (lower(english) gin_trgm_ops);
    CREATE INDEX translation_german_idx  ON english.translation USING gin (lower(german)  gin_trgm_ops);
    CREATE INDEX translation_spanish_idx ON spanish.translation USING gin (lower(spanish) gin_trgm_ops);
    CREATE INDEX translation_german_idx  ON spanish.translation USING gin (lower(german)  gin_trgm_ops);

    CREATE OR REPLACE VIEW common.translation AS
      SELECT id, german  AS source, english AS target, 'DE' AS source_language, 'EN' AS target_language FROM english.translation UNION ALL
      SELECT id, english AS source, german  AS target, 'EN' AS source_language, 'DE' AS target_language FROM english.translation UNION ALL
      SELECT id, german  AS source, spanish AS target, 'DE' AS source_language, 'ES' AS target_language FROM spanish.translation UNION ALL
      SELECT id, spanish AS source, german  AS target, 'ES' AS source_language, 'DE' AS target_language FROM spanish.translation;
 
    \i /tmp/script-en.sql
    \i /tmp/script-es.sql

EOSQL

rm /tmp/script-en.sql
rm /tmp/script-es.sql
