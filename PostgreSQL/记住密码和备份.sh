vim ~/.pgpass
# hostname:port:database:username:password
chmod 600 ~/.pgpass

/usr/local/pgsql/src/bin/pg_dump/pg_dump -U mastodon -f mastodon > mastodon_pg.sql

# 不安全方式
PGPASSWORD="$pg_password" pg_dump -p 5432 -U mastodon > mastodon_pg.sql