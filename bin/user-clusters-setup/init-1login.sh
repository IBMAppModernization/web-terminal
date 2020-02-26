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
  done < "${config_file}"
  echo "account.name=" ${account_name}
  echo "number_of_users=" ${number_of_users}
  echo "user_offset=" ${user_offset}
  echo "account_apikey=" ${account_apikey}
  echo "ibmcloud.admin.org=" ${ibmcloud_admin_org}
  echo "ibmcloud.admin.space=" ${ibmcloud_admin_space}
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
echo "=====> login to ibmcloud"
echo ibmcloud login --apikey "${account_apikey}" -r "${ibmcloud_admin_region}" -g $ibmcloud_admin_resourcegroup
ibmcloud login --apikey "${account_apikey}"  -r "${ibmcloud_admin_region}" -g $ibmcloud_admin_resourcegroup

echo ibmcloud target --cf-api "${ibmcloud_admin_cfapi}" -s "${ibmcloud_admin_space}"
ibmcloud target --cf-api "${ibmcloud_admin_cfapi}" -s "${ibmcloud_admin_space}"