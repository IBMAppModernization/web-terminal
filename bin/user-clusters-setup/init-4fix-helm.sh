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

echo "=====> fix helm on clusters"
for (( n=$user_offset;n<($number_of_users+$user_offset);n++ ))
do
	ZONE="dal10"
	CLUSTER_NAME="usbankiksuser${n}"
	
	ibmcloud ks cluster config --cluster "${CLUSTER_NAME}"
	export KUBECONFIG="/${HOME}/.bluemix/plugins/container-service/clusters/${CLUSTER_NAME}/kube-config-${ZONE}-${CLUSTER_NAME}.yml"

	kubectl config current-context

	# Fix the Helm install
	kubectl create serviceaccount --namespace kube-system tiller
	sleep 5s
	kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
	sleep 5s
	helm init --upgrade
	sleep 5s
	kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

done
