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
  echo "$config_file not found."
fi

# LOGIN
echo "=====> login to ibmcloud"
ibmcloud login -u "${ibmcloud_admin_username}" -p "${ibmcloud_admin_password}" -r "${ibmcloud_admin_region}" -g $ibmcloud_admin_resourcegroup

#ibmcloud target --cf-api "${ibmcloud_admin_cfapi}" 
ibmcloud target --cf-api "${ibmcloud_admin_cfapi}" -s dev -o $ibmcloud_admin_org

# CREATE CLUSTERS
echo "=====> 2. create clusters"
for (( n=$cluster_offset;n<($number_of_ttyd_clusters+$cluster_offset);n++ ))
do
	#echo ibmcloud ks cluster create classic --name "admin_iks_cluster_ttyd_${n}" --zone $ibmcloud_admin_zone --machine-type $ibmcloud_admin_flavor --hardware shared --workers $ibmcloud_admin_cluster_workers --public-vlan $ibmcloud_admin_vlan_public_id --private-vlan $ibmcloud_admin_vlan_private_id
	echo ibmcloud ks cluster create classic --name "admin_iks_cluster_ttyd_${n}" --zone $ibmcloud_admin_zone --machine-type $ibmcloud_admin_flavor --hardware shared --workers $ibmcloud_admin_cluster_workers --public-vlan $ibmcloud_admin_vlan_public_id --private-vlan $ibmcloud_admin_vlan_private_id
	ibmcloud ks cluster create classic --name "admin_iks_cluster_ttyd_${n}" --zone $ibmcloud_admin_zone --machine-type $ibmcloud_admin_flavor --hardware shared --workers $ibmcloud_admin_cluster_workers --public-vlan $ibmcloud_admin_vlan_public_id --private-vlan $ibmcloud_admin_vlan_private_id
done