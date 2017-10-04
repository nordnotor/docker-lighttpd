[![](http://dockeri.co/image/notor93/docker-lighttpd-alpine)](https://index.docker.io/u/notor93/docker-lighttpd-alpine/)

Lighttpd 1.4.45 
=========
Lighttpd server on linux alpine.

## Build using:
`docker build -t lighttpd .`

`docker run --name lighttpd -d -p 80:80 -v <project-directory>:/var/www  lighttpd`

## Run using:
`docker run --name lighttpd -d -p 80:80 -v <project-directory>:/var/www  notor93/docker-lighttpd-alpine`

## Environment Variables:
 - PHP_CONTAINER_HOST - This is an optional variable. It takes the name of the host and inserts it up the `host` in FastCGI Server conf file `"host" => "INSERTED_IP_VALUE",`. (since 1.4.46, DNS name is resolved to first IP at lighttpd startup)

## Docker Compose:
Add the following lines in an `docker-compose.yml` file:

    lighttpd:
      image: notor93/docker-lighttpd-alpine
      ports:
        - "<http-port>:80"
      volumes:
        - "<conf-enabled-directory>:/etc/lighttpd/conf-enabled"
        - "<project-directory>:/var/www"
        
    lighttpd:
      container_name: lighttpd
      image: notor/lighttpd
      build: ./images/lighttpd
      ports:
        - "80:80"
      volumes:
        - "<project-directory>:/var/www/html"
        - "<project-log-directory>:/var/log/lighttpd"
        - "<conf-enabled-directory>:/etc/lighttpd/conf-enabled"
      environment:
          PHP_CONTAINER_HOST: ${PHP_CONTAINER_HOST}
