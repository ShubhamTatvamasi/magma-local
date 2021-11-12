# backup

backup database:
```bash
kubectl -n orc8r exec -it postgresql-postgresql-0 -- \
  bash -c 'PGPASSWORD=postgres pg_dump -U postgres magma' > magma-db.sql
```

