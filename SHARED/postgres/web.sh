#!/bin/bash
MSG_COLOR="\033[41m"

echo -e "$MSG_COLOR$(hostname): Create a new PostgreSQL user and database\033[0m"
sudo -u postgres psql -c "CREATE USER myuser WITH PASSWORD 'mypassword';"
sudo -u postgres psql -c "CREATE DATABASE mydatabase OWNER myuser;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser;"

# peer access to myuser
# sudo sh -c 'echo "local   all             myuser                                  peer" >> /etc/postgresql/14/main/pg_hba.conf'
sudo service postgresql restart

sudo -u postgres psql -d mydatabase -c "DROP TABLE test;"

echo -e "$MSG_COLOR$(hostname): Import dump.sql and set user privileges\033[0m"
# PGPASSWORD=mypassword sudo -u postgres psql -U myuser -h localhost -d mydatabase -f /vagrant/provision/dump.sql # change to ./provision/dump.sql
sudo -u postgres psql -d mydatabase -f /dump.sql
sudo -u postgres psql -d mydatabase -c "GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE messages TO myuser;" # uneeded?
sudo -u postgres psql -d mydatabase -c "GRANT USAGE, SELECT, UPDATE ON SEQUENCE messages_id_seq TO myuser;"
sudo -u postgres psql -d mydatabase -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO myuser;"
sudo -u postgres psql -d mydatabase -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO myuser;"
sudo -u postgres psql -d mydatabase -c "GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser;"

echo -e "$MSG_COLOR$(hostname): View users and databases in PostgreSQL\033[0m"
sudo -u postgres psql -c "\du"
sudo -u postgres psql -c "\list"
sudo -u postgres psql -d mydatabase -c "\dt"