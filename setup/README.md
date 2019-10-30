## Setup

Each participant will be assigned their own usernumber, which will correspond with the names of the Kubernetes cluster and IBM Cloud services that are assigned to you for this workshop. 

* Your IKS Cluster Name: &lt;account&gt;_iks_cluster_user&lt;usernumber&gt;,
* Your Web-Terminal URL: http://&lt;terminal-cluster&gt;.us-south.containers.appdomain.cloud/term &lt;usernumber&gt;
* IKS Kubernetes Cluster: 
  * Cluster:
  * Ingress subdomain: &lt;account&gt;iksclusteruser&lt;usernumber&gt;.us-south.containers.appdomain.cloud

1. Go to your Cloud Resources List at https://cloud.ibm.com/resources,
2. Browse to your cluster number and click your cluster name, e.g. &lt;account&gt;_iks_cluster_user&lt;usernumber&gt;,
3. Go to the Access tab to view the access commands, copy-paste these in your web-terminal,
4. Go to your Web-Terminal URL ending with your usernumber, e.g. /term1 for user 1,
5. From the web-terminal, 
   1. login to your IBM Cloud, e.g. "ibmcloud login -a cloud.ibm.com -r us-south -g ibm-advocates-rg"
   2. get the cluster config for your cluster, e.g. "ibmcloud ks cluster config --cluster &lt;account&gt;_iks_cluster_user&lt;usernumber&gt;",
   3. copy-paste the EXPORT command, e.g. "export KUBECONFIG=/root/.bluemix/plugins/container-service/clusters/&lt;account&gt;_iks_cluster_user&lt;usernumber&gt;/kube-config-dal10-&lt;account&gt;_iks_cluster_user&lt;usernumber&gt;.yml",
   4. verify you are connected: "kubectl version --short",
   
# Labs

## Istio

* Go to 

## Kafka and Event Streams

* Go to https://github.com/remkohdev/kafka101
* In the "Lab01 - Setup", go to https://github.com/remkohdev/kafka101/blob/master/Lab01/README.md#initialize-the-event-streams-service, because you are already logged into IBM Cloud and the IBM Event Streams plugin is already installed on your web-terminal, skip to the "Initialize the Event Streams Service" section, run the command "ibmcloud es init", and choose the number matching with the eventstreams service ending in your usernumber, e.g. "3. <account>-eventstreams-user<usernumber>",

* Go to Lab02, https://github.com/remkohdev/kafka101/tree/master/Lab02
* Read the introduction and skip the Download section, go to the Lab section, https://github.com/remkohdev/kafka101/blob/master/Lab02/README.md#lab
* After you have the producer running and waiting for user input, open a new browser tab to run the consumer,

* Go to Lab03, 
* If you have the Spring Boot CLI already installed, skip to the "Create a Spring App" section, https://github.com/remkohdev/kafka101/blob/master/Lab03/README.md#create-a-spring-app

