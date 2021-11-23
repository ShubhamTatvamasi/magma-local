# backup

backup database:
```bash
kubectl -n orc8r exec -it postgresql-postgresql-0 -- \
  bash -c 'PGPASSWORD=postgres pg_dump -U postgres magma' > magma-db.sql
```

### docker restore

start postgresql database with docker:
```bash
docker run -d -p 5432:5432 \
  --name postgres \
  -e POSTGRES_PASSWORD=postgres \
  postgres
```

connect with postgresql database:
```bash
docker exec -it postgres bash -c 'PGPASSWORD=postgres psql -U postgres'
```

create `magma` database to restore:
```sql
CREATE DATABASE magma;
```

restore from backup file:
```bash
docker exec -i postgres bash -c 'PGPASSWORD=postgres psql -U postgres -d magma' < magma-db.sql
```
