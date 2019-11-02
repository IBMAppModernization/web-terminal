#!/bin/bash

# READ PROPERTIES
config_file="./admin.properties"
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

# LOGIN
echo "=====> login to ibmcloud"
ibmcloud login -u "${ibmcloud_admin_username}" -p "${ibmcloud_admin_password}" -r "${ibmcloud_admin_region}" -g $ibmcloud_admin_resourcegroup

ibmcloud target --cf-api "${ibmcloud_admin_cfapi}" -s dev -o $ibmcloud_admin_org


for (( n=$user_offset;n<($number_of_ttyd_clusters+$user_offset);n++ ))
do
	CLUSTERNAME="admin_iks_cluster_ttyd_${n}"
	ibmcloud ks cluster config --cluster $CLUSTERNAME
	export KUBECONFIG="/${HOME}/.bluemix/plugins/container-service/clusters/${CLUSTERNAME}/kube-config-dal10-${CLUSTERNAME}.yml"
	kubectl config current-context

	helm install --name web-terminal ../../chart/web-terminal/ --set participantCount=40 --set tlsSecret="adminiksclusterttyd${n}" --set fullDomain="adminiksclusterttyd${n}.us-south.containers.appdomain.cloud" --set repository="${docker_registry}/${docker_image_name}" --set tag="${docker_image_tag}"
	
done
