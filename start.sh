# This script starts the database server.
echo "Creating user $user for databases loaded from $url"
# Now the provided user credentials are added
/usr/sbin/mysqld &
sleep 5
echo "Creating user"
echo "CREATE USER '$user' IDENTIFIED BY '$password'" | mysql --default-character-set=utf8
echo "REVOKE ALL PRIVILEGES ON *.* FROM '$user'@'%'; FLUSH PRIVILEGES" | mysql --default-character-set=utf8
echo "GRANT SELECT ON *.* TO '$user'@'%'; FLUSH PRIVILEGES" | mysql --default-character-set=utf8
echo "finished"
echo "CREATE DATABASE wordpress" | mysql --default-character-set=utf8

if [ "$right" = "WRITE" ]; then
echo "adding write access"
echo "GRANT ALL PRIVILEGES ON *.* TO '$user'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql --default-character-set=utf8
fi
# And we restart the server to go operational
mysqladmin shutdown
echo "Starting MySQL Server"
/usr/sbin/mysqld
