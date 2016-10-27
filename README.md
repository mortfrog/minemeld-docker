# minemeld-docker

Unstable, go away.

MineMeld inside a docker container.

Based on phusion baseimage-docker, inspired by @swannysec and @bilalbox

You still here ? Suggested way to run this docker:

````
docker-compose up
````

Without docker-compose:

````
docker run -it --tmpfs /run -P jtschichold/minemeld
````

To backup data when docker-compose is not used:

````
docker run --rm --volumes-from d99227817617 -v $(pwd):/backup ubuntu:14.04 tar cvf /backup/backup.tar /opt/minemeld/local/config /opt/minemeld/local/data /opt/minemeld/local/trace /opt/minemeld/local/prototypes /opt/minemeld/local/trace
````
