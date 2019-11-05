#!/bin/bash

# READ PROPERTIES
config_file="./admin.properties"
if [ -f "${config_file}" ]
then
  # Internal Field Separator (IFS) 
  while IFS='=' read -r key value
  do
    #key=$(echo $key | tr '.' '_')
	key=$(echo $key | tr .-/ _ | tr -cd 'A-Za-z0-9_')
    eval ${key}=\${value}
  done < "${config_file}"
else  
  echo "${config_file} not found."
fi

#docker build --no-cache -t $docker_image_name -f Dockerfile-ttyd-iks-labs .
docker tag "${docker_image_name}:latest" "${docker_registry}/${docker_image_name}:${docker_image_tag}"
docker login -u "${docker_username}" -p "${docker_password}"
docker push "${docker_registry}/${docker_image_name}:${docker_image_tag}"
