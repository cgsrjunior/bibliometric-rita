# metadata-article-ml
This repository is going to host a project when we want to analysis article metadata to learn information about the publishers

# Commands to run the docker container (TBD)
sudo docker build -t docker-comp /mnt/d/metadata-article-ml/
sudo docker run -it docker-comp /bin/bash

# Command to run docker container on backdoor 80 (TBD)
sudo docker run -tp 8787:8787 docker-comp

