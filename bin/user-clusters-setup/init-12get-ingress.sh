#!/bin/bash

# READ PROPERTIES
config_file="./init.properties"
if [ -f "$config_file" ]
then
  # Internal Field Separator (IFS) 
  while IFS='=' read -r key value
  do
    #key=$(echo $key | tr '.' '_')
	key=$(echo $key | tr .-/ _ | tr -cd 'A-Za-z0-9_')
    eval ${key}=\${value}
  done < "$config_file"
else  
  echo "$config_file not found."
fi

# CREATE CLUSTERS
echo "=====> 2. create clusters"
for (( n=$user_offset;n<($number_of_users+$user_offset);n++ ))
do
    echo "get ingress for cluster ${n}"
	ibmcloud ks cluster get --cluster "${account_name}iksclusteruser${n}" | grep Ingress

done
