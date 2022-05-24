#for local testing/or local docker container
image=ngnix-main
container=nginx-main
port=80

docker stop $container
docker image rm $image
docker rm $container
docker build -t $image -f Dockerfile .
docker run --env PORT=80 -d -p $port:80 --name $container $image
