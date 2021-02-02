# Hypertrace with postgres
Hypertrace uses two different types of store currently
- document store
- Olap store

By default, we run docker-compose with mongo as a document store. Recently, we have also added support for postgres as an alternative to mongo.
Docker-compose setup in this directory uses postgres out of the box.

## References
- https://github.com/hypertrace/hypertrace/issues/114
- https://github.com/hypertrace/hypertrace/issues/124