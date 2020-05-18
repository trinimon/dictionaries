# A dictionaries Docker image based on PostgreSQL

This image contains a PostgreSQL database with schemas for an english and a spanish dictionary. 

The database is called *dictionaries* which is owned by the user *translator*. Schemas inside the database are named corresponding to the language they contain, e.g. *english* or *spanish*.

# Building an image

Based on the docker file an image can simply be build by:

```
docker build -t trinimon/dictionary:latest .
```

# Running a container

The following command starts a container and sets the postgres admin users password to *secret*:

```
docker run --rm 
           --publish 5433:5432 
           --env POSTGRES_PASSWORD=secret trinimon/dictionary:latest
```

# Using the container

Using the above shown command, the database is listening on port 5433. The user *translator* has the pre-defined password *secret*. navigate to the dictionaries database and its schemas to find the dictionaries data tables.  

# Licenses

For the lisence of this image look [here](LICENSE).

For licenses of word lists see [here](LICENSES_THIRD_PARTY.md).