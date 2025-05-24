docker network ls 
docker network inspect <networkname>
docker network connect <networkname> <containername>

docker container inspect <containername>


eksctl update addon --name coredns --cluster simple-bank --region ap-south-1          