#!/bin/bash

# GETOPS
while getopts ":hp" opt; do
  case ${opt} in
    h ) # process option a
	  echo "Usage:"
	  echo "    init -p          properties file"
	  exit 0
      ;;
    p ) # process option p
      ;;
    \? ) 
	  echo "Usage: cmd [-h] [-p]"
	  exit 0
      ;;
  esac
done

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
  echo "account.name=" ${account_name}
  echo "number_of_users=" ${number_of_users}
  echo "user_offset=" ${user_offset}
  echo "ibmcloud.admin.username=" ${ibmcloud_admin_username}
  echo "ibmcloud.admin.password=" ${ibmcloud_admin_password}
  echo "ibmcloud.admin.org=" ${ibmcloud_admin_org}
  echo "ibmcloud.admin.resourcegroup=" ${ibmcloud_admin_resourcegroup}
  echo "ibmcloud.admin.cfapi=" ${ibmcloud_admin_cfapi}
  echo "ibmcloud.admin.region=" ${ibmcloud_admin_region}
  echo "ibmcloud.admin.zone=" ${ibmcloud_admin_zone}
  echo "ibmcloud.admin.flavor=" ${ibmcloud_admin_flavor}
  echo "ibmcloud.admin.vlan.private.id=" ${ibmcloud_admin_vlan_private_id}
  echo "ibmcloud.admin.vlan.public.id=" ${ibmcloud_admin_vlan_public_id}
  echo "ibmcloud.admin.cluster.workers=" ${ibmcloud_admin_cluster_workers}
else  
  echo "$config_file not found."
fi

# LOGIN
echo "=====> 1. login to ibmcloud"
echo ibmcloud login -u "${ibmcloud_admin_username}" -p "${ibmcloud_admin_password}" -r "${ibmcloud_admin_region}" -g $ibmcloud_admin_resourcegroup
ibmcloud login -u "${ibmcloud_admin_username}" -p "${ibmcloud_admin_password}" -r "${ibmcloud_admin_region}" -g $ibmcloud_admin_resourcegroup

echo ibmcloud target --cf-api "${ibmcloud_admin_cfapi}" -s dev -o $ibmcloud_admin_org
ibmcloud target --cf-api "${ibmcloud_admin_cfapi}" -s dev -o $ibmcloud_admin_org

# CREATE CLUSTERS
echo "=====> 2. create clusters"
for (( n=$user_offset;n<($number_of_users+$user_offset);n++ ))
do
    echo "create cluster for user ${n}"
    # a. create cluster
	ibmcloud ks cluster create classic --name "${account_name}_iks_cluster_user${n}" --zone $ibmcloud_admin_zone --machine-type $ibmcloud_admin_flavor --hardware shared --workers $ibmcloud_admin_cluster_workers --public-vlan $ibmcloud_admin_vlan_public_id --private-vlan $ibmcloud_admin_vlan_private_id

done

# CREATE KAFKA EVENT STREAMS
echo "=====> 3. create kafka event streams"
#ibmcloud plugin install event-streams
for (( n=$user_offset;n<($number_of_users+$user_offset);n++ ))
do
    echo "create kafka event streams for user ${n}"
	ibmcloud resource service-instance-create "${account_name}-eventstreams-user${n}" messagehub standard us-south
done