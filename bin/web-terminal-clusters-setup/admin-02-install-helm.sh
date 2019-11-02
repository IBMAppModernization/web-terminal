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
	echo "=====>${CLUSTERNAME}"

	ibmcloud ks cluster config --cluster $CLUSTERNAME
	export KUBECONFIG="/${HOME}/.bluemix/plugins/container-service/clusters/${CLUSTERNAME}/kube-config-dal10-${CLUSTERNAME}.yml"
	kubectl config current-context

	echo "create serviceaccount"
	kubectl create serviceaccount --namespace kube-system tiller
	echo "create clusterrolebinding"
	kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
	echo "helm init"
	helm init --upgrade
	echo "kubectl patch"
	kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
	
done
