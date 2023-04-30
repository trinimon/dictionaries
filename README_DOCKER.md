# About the Dictionaries

The word lists imported in the database have been publishd along with the dictionary program *ding* by Frank Richter.

Program and lists are shipped with *GNU FDL* and *GPL* and *Creative Commons cc-by-sa* licenses. Many thanks to Frank for making these lists available!  

# Image Description

This image contains a PostgreSQL database with schemas for an english and a spanish dictionary. 

The database is called *dictionaries* which is owned by the user *translator*. 

Schemas inside the database are named corresponding to the language they contain, e.g. *english* or *spanish*. 

Tables are named *translations*.

# Tags

* **1.0, latest**: alpine 3.11.6, Postgres 12.10, distionaries as of 30.04.2023 

# Requirements

The docker image is available for `amd64`, `arm/v7` and `arm64` platforms.

# Running

The following command starts a container and sets the postgres admin users password to *secret*:

```
docker run --rm -d \
           --publish 5433:5432 \
           --env POSTGRES_PASSWORD=secret trinimon/dictionaries:latest
```

The database is listening on port 5433. The user *translator* has the pre-defined password *secret*. 

Navigate to the dictionaries database and its schemas to find the dictionaries data tables.

# Licenses

Checkout licence information at [alpine](https://hub.docker.com/_/alpine) and [Postgres](https://www.postgresql.org/about/licence/).
 
For license information of the word list see [this page](https://github.com/trinimon/dictionaries/blob/master/LICENSES_THIRD_PARTY.md).   

