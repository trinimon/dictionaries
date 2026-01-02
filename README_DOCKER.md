# About the Dictionaries

The word lists imported into this database were originally published alongside the dictionary program *DING* by Frank Richter.

The program and lists are distributed under the *GNU FDL*, *GPL*, and *Creative Commons CC-BY-SA* licenses.

Many thanks to Frank Richter for making these lists available!

# Image Description

This image contains a PostgreSQL database with schemas for English and Spanish dictionaries.

The database is named *dictionaries* and is owned by the user *translator*.  

Schemas inside the database are named according to the language they contain, e.g. *english* or *spanish*.
  
Each schema contains a single table named *translations*.

# Tags

* **1.2, latest**: Alpine 3.23, PostgreSQL 18.1, dictionaries as of 2026-01-02
* **1.1, latest**: Alpine 3.18, PostgreSQL 16.0, dictionaries as of 2023-11-12
* **1.0**: Alpine 3.11.6, PostgreSQL 12.10, dictionaries as of 2023-04-30

# Requirements

The Docker image is available for `amd64`, `arm/v6`, `arm/v7` and `386` platforms.

# Running

The following command starts a container and sets the PostgreSQL admin user password to *secret*:

```bash
docker run --rm -d
           --publish 5433:5432 \
           --env POSTGRES_PASSWORD=secret trinimon/dictionaries:latest
```

The database port is published on port 5433. The user *translator* has the predefined password *secret*.

Please note: during the first startup, the word lists are imported into the database.
This initialization process may take a few minutes, which delays the availability of the database login.
On subsequent container starts, no import is performed and the database becomes available more quickly.

Once the import is complete, connect to the dictionaries database and explore the language schemas to find the dictionary tables.

# Licenses

See license information for [Alpine](https://hub.docker.com/_/alpine) and [PostgreSQL](https://www.postgresql.org/about/licence/).

For license information of the word list see [this page](https://github.com/trinimon/dictionaries/blob/master/LICENSES_THIRD_PARTY.md).
