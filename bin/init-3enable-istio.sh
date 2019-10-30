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

echo "=====> enable istio on clusters"
for (( n=$user_offset;n<($number_of_users+$user_offset);n++ ))
do
    echo "create cluster for user ${n}"
	ibmcloud ks cluster addon enable istio --cluster "${account_name}_iks_cluster_user${n}"
	ibmcloud ks cluster addon enable istio-extras --cluster "${account_name}_iks_cluster_user${n}"
	ibmcloud ks cluster addon enable istio-sample-bookinfo --cluster "${account_name}_iks_cluster_user${n}"
done
