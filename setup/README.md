## Setup

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

## Kafka and Event Streams

* Go to https://github.com/remkohdev/kafka101
* In the "Lab01 - Setup", go to https://github.com/remkohdev/kafka101/blob/master/Lab01/README.md#initialize-the-event-streams-service, because you are already logged into IBM Cloud and the IBM Event Streams plugin is already installed on your web-terminal, skip to the "Initialize the Event Streams Service" section, run the command "ibmcloud es init", and choose the number matching with the eventstreams service ending in your usernumber, e.g. "3. <account>-eventstreams-user<usernumber>",
* Go to Lab02, https://github.com/remkohdev/kafka101/tree/master/Lab02
* Read the introduction and skip the Download section, go to the Lab section, https://github.com/remkohdev/kafka101/blob/master/Lab02/README.md#lab
* After you have the producer running and waiting for user input, open a new browser tab to run the consumer,
* 

broker-4-65fy1qk7jm9ybxjr.kafka.svc01.us-south.eventstreams.cloud.ibm.com:9093, broker-0-65fy1qk7jm9ybxjr.kafka.svc01.us-south.eventstreams.cloud.ibm.com:9093, broker-1-65fy1qk7jm9ybxjr.kafka.svc01.us-south.eventstreams.cloud.ibm.com:9093, broker-5-65fy1qk7jm9ybxjr.kafka.svc01.us-south.eventstreams.cloud.ibm.com:9093, broker-3-65fy1qk7jm9ybxjr.kafka.svc01.us-south.eventstreams.cloud.ibm.com:9093, broker-2-65fy1qk7jm9ybxjr.kafka.svc01.us-south.eventstreams.cloud.ibm.com:9093

bash bin/kafka-console-consumer.sh --bootstrap-server broker-4-65fy1qk7jm9ybxjr.kafka.svc01.us-south.eventstreams.cloud.ibm.com:9093, broker-0-65fy1qk7jm9ybxjr.kafka.svc01.us-south.eventstreams.cloud.ibm.com:9093, broker-1-65fy1qk7jm9ybxjr.kafka.svc01.us-south.eventstreams.cloud.ibm.com:9093, broker-5-65fy1qk7jm9ybxjr.kafka.svc01.us-south.eventstreams.cloud.ibm.com:9093, broker-3-65fy1qk7jm9ybxjr.kafka.svc01.us-south.eventstreams.cloud.ibm.com:9093, broker-2-65fy1qk7jm9ybxjr.kafka.svc01.us-south.eventstreams.cloud.ibm.com:9093 --consumer.config mykafka.properties --topic greetings