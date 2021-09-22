# flyway-postgresql
Flyway and PostgreSQL tests (docker-compose)

Run suite-test:
```
git clone https://github.com/vagnerd/flyway-postgresql.git
sudo chown -R 101 sql_versions
docker-compose up
```

Access flyway container:
```
docker exec -it flyway-postgresql_flyway_1 /bin/bash 
```

SQL migrate versions directory:
```
./sql_versions
```

Run info/migrate commands:
```
flyway info
flyway migrate
```

Access PostgreSQL database
```
docker exec -it flyway-postgresql_flyway_1 psql
```

Example use:
```
docker exec -it flyway-postgresql_flyway_1 /bin/bash 
flyway@597e2a768b41:~$ flyway info 
Flyway Community Edition 7.5.1 by Redgate
Database: jdbc:postgresql://postgres:5432/test-db (PostgreSQL 12.8)
Schema version: << Empty Schema >>

+-----------+---------+------------------+------+--------------+---------+
| Category  | Version | Description      | Type | Installed On | State   |
+-----------+---------+------------------+------+--------------+---------+
| Versioned | 1       | Initial Database | SQL  |              | Pending |
| Versioned | 2       | Insert employees | SQL  |              | Pending |
| Versioned | 4       | Create products  | SQL  |              | Pending |
| Versioned | 5       | Create region    | SQL  |              | Pending |
| Versioned | 6       | fix region       | SQL  |              | Pending |
| Versioned | 30      | Drop employees   | SQL  |              | Pending |
+-----------+---------+------------------+------+--------------+---------+

flyway@597e2a768b41:~$ flyway -target=6 migrate
Flyway Community Edition 7.5.1 by Redgate
Database: jdbc:postgresql://postgres:5432/test-db (PostgreSQL 12.8)
Successfully validated 6 migrations (execution time 00:00.024s)
Creating Schema History table "public"."flyway_schema_history" ...
Current version of schema "public": << Empty Schema >>
Migrating schema "public" to version "1 - Initial Database"
Migrating schema "public" to version "2 - Insert employees"
Migrating schema "public" to version "4 - Create products"
Migrating schema "public" to version "5 - Create region"
Migrating schema "public" to version "6 - fix region"
Successfully applied 5 migrations to schema "public" (execution time 00:00.103s)

flyway@597e2a768b41:~$ flyway -target=6 info
Flyway Community Edition 7.5.1 by Redgate
Database: jdbc:postgresql://postgres:5432/test-db (PostgreSQL 12.8)
Schema version: 6

+-----------+---------+------------------+------+---------------------+--------------+
| Category  | Version | Description      | Type | Installed On        | State        |
+-----------+---------+------------------+------+---------------------+--------------+
| Versioned | 1       | Initial Database | SQL  | 2021-09-22 20:01:51 | Success      |
| Versioned | 2       | Insert employees | SQL  | 2021-09-22 20:01:51 | Success      |
| Versioned | 4       | Create products  | SQL  | 2021-09-22 20:01:51 | Success      |
| Versioned | 5       | Create region    | SQL  | 2021-09-22 20:01:51 | Success      |
| Versioned | 6       | fix region       | SQL  | 2021-09-22 20:01:51 | Success      |
| Versioned | 30      | Drop employees   | SQL  |                     | Above Target |
+-----------+---------+------------------+------+---------------------+--------------+

flyway@597e2a768b41:~$ flyway info
Flyway Community Edition 7.5.1 by Redgate
Database: jdbc:postgresql://postgres:5432/test-db (PostgreSQL 12.8)
Schema version: 6

+-----------+---------+------------------+------+---------------------+---------+
| Category  | Version | Description      | Type | Installed On        | State   |
+-----------+---------+------------------+------+---------------------+---------+
| Versioned | 1       | Initial Database | SQL  | 2021-09-22 20:01:51 | Success |
| Versioned | 2       | Insert employees | SQL  | 2021-09-22 20:01:51 | Success |
| Versioned | 4       | Create products  | SQL  | 2021-09-22 20:01:51 | Success |
| Versioned | 5       | Create region    | SQL  | 2021-09-22 20:01:51 | Success |
| Versioned | 6       | fix region       | SQL  | 2021-09-22 20:01:51 | Success |
| Versioned | 30      | Drop employees   | SQL  |                     | Pending |
+-----------+---------+------------------+------+---------------------+---------+

flyway@597e2a768b41:~$ flyway migrate
Flyway Community Edition 7.5.1 by Redgate
Database: jdbc:postgresql://postgres:5432/test-db (PostgreSQL 12.8)
Successfully validated 6 migrations (execution time 00:00.030s)
Current version of schema "public": 6
Migrating schema "public" to version "30 - Drop employees"
Successfully applied 1 migration to schema "public" (execution time 00:00.039s)

flyway@597e2a768b41:~$ flyway validate
Flyway Community Edition 7.5.1 by Redgate
Database: jdbc:postgresql://postgres:5432/test-db (PostgreSQL 12.8)
Successfully validated 6 migrations (execution time 00:00.036s)

flyway@597e2a768b41:~$ psql
psql (12.8 (Ubuntu 12.8-0ubuntu0.20.04.1))
Type "help" for help.

test-db=# \dt
                 List of relations
 Schema |         Name          | Type  |   Owner   
--------+-----------------------+-------+-----------
 public | categories            | table | test-user
 public | flyway_schema_history | table | test-user
 public | orders                | table | test-user
 public | products              | table | test-user
 public | region                | table | test-user
(5 rows)

```
