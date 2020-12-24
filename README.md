![docker build automated](https://img.shields.io/docker/cloud/automated/dotriver/mariadb)
![docker build status](https://img.shields.io/docker/cloud/build/dotriver/mariadb)
![docker build status](https://img.shields.io/docker/cloud/pulls/dotriver/mariadb)

# MariaDB + PHPMyAdmin on Alpine Linux + S6 Overlay

# Auto configuration parameters :

- ROOT_PASSWORD=password ( MariaDB ROOT Password )
- DAILY_BACKUPS=YES ( FULL | PART | BOTH | NONE )
# DAILY_BACKUPS
- FULL : One SQL dump per day 
- PART : One SQL per table dump per hour 
- BOTH : One SQL dump per day + one SQL dump per table per hour
- NONE : No backups

# Known Bugs :
- Don't dump directly to an nfs storage or volume, it causes mariadb crash ( auto dump fixed )

# Compose file exemple

```
version: '3'

services:

  mariadb:
    image: dotriver/mariadb
    environment:
      - ROOT_PASSWORD=password
      - DB_0_NAME=db0
      - DB_0_PASSWORD=passworddb0
    ports:
      - 3306:3306
      - 8080:80
    volumes:
      - mariadb-data:/var/lib/mysql/
      - mariadb-config:/etc/mysql/
    networks:
      default:
    
volumes:
    mariadb-data:
    mariadb-config:

```