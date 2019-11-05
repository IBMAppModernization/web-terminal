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
    echo "create cluster for user ${n}"
    # a. create cluster
	ibmcloud ks cluster create classic --name "${account_name}iksuser${n}" --zone $ibmcloud_admin_zone --machine-type $ibmcloud_admin_flavor --hardware shared --workers $ibmcloud_admin_cluster_workers --public-vlan $ibmcloud_admin_vlan_public_id --private-vlan $ibmcloud_admin_vlan_private_id
done

# CREATE KAFKA EVENT STREAMS
echo "=====> 3. create kafka event streams"
#ibmcloud plugin install event-streams
for (( n=$user_offset;n<($number_of_users+$user_offset);n++ ))
do
    echo "create kafka event streams for user ${n}"
	ibmcloud resource service-instance-create "${account_name}esuser${n}" messagehub standard "${ibmcloud_admin_region}"
	ibmcloud resource service-key-create "${account_name}esuser${n}credentials1" Manager --instance-name "${account_name}esuser${n}"
done