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
    eval $key=$value
  done < "${config_file}"
else  
  echo "${config_file} not found."
fi

# REMOVE CLUSTER
for (( n=$cluster_offset;n<($number_of_ttyd_clusters + $cluster_offset);n++ ))
do
    echo "remove cluster ${n}"
	ibmcloud ks cluster rm -f -c "admin_iks_cluster_ttyd_${n}"
done
