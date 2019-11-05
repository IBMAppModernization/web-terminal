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
  echo "$config_file not found."
fi

# LOGIN
echo "=====> login to ibmcloud"
ibmcloud login -u "${ibmcloud_admin_username}" -p "${ibmcloud_admin_password}" -r "${ibmcloud_admin_region}" -g $ibmcloud_admin_resourcegroup

echo ibmcloud target --cf-api "${ibmcloud_admin_cfapi}" 
ibmcloud target --cf-api "${ibmcloud_admin_cfapi}" 
#ibmcloud target --cf-api "${ibmcloud_admin_cfapi}" -s dev -o $ibmcloud_admin_org


for (( n=$cluster_offset;n<($number_of_ttyd_clusters+$cluster_offset);n++ ))
do
	CLUSTERNAME="admin_iks_cluster_ttyd_${n}"
	
	echo ibmcloud ks cluster config --cluster $CLUSTERNAME
	ibmcloud ks cluster config --cluster $CLUSTERNAME

	ibmcloud ks cluster config --cluster $CLUSTERNAME
	KUBECONF="${HOME}/.bluemix/plugins/container-service/clusters/${CLUSTERNAME}/kube-config-${ibmcloud_admin_zone}-${CLUSTERNAME}.yml"
	export KUBECONFIG=$KUBECONF
	kubectl config current-context

	echo helm install --name web-terminal ../../chart/web-terminal/ --set participantCount=$participantCount --set tlsSecret="adminiksclusterttyd${n}" --set fullDomain="adminiksclusterttyd${n}.${ibmcloud_admin_region}.containers.appdomain.cloud" --set repository="${docker_registry}/${docker_image_name}" --set tag="${docker_image_tag}"
	
	helm install --name web-terminal ../../chart/web-terminal/ --set participantCount=$participantCount --set tlsSecret="adminiksclusterttyd${n}" --set fullDomain="adminiksclusterttyd${n}.${ibmcloud_admin_region}.containers.appdomain.cloud" --set repository="${docker_registry}/${docker_image_name}" --set tag="${docker_image_tag}"
	
done
