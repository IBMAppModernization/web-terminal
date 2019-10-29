## Setup

* Your IKS Cluster Name: &lt;account&gt;_iks_cluster_user&lt;usernumber&gt;,
* Your Web-Terminal URL: http://ibmiksclusterwebterminals.us-south.containers.appdomain.cloud/term &lt;usernumber&gt;
* IKS Kubernetes Cluster: 
  * Cluster:
  * Ingress subdomain: &lt;account&gt;iksclusteruser&lt;usernumber&gt;.us-south.containers.appdomain.cloud

1. Go to your Cloud Resources List at https://cloud.ibm.com/resources,
2. Browse to your cluster number and click yoru cluster name, e.g. &lt;account&gt;_iks_cluster_user&lt;usernumber&gt;,
3. Go to the Access tab to view the access commands, copy-paste these in your web-terminal,
4. Go to your Web-Terminal URL ending with your usernumber, e.g. /term1 for user 1,
5. From the web-terminal, 
   1. login to your IBM Cloud, e.g. "ibmcloud login -a cloud.ibm.com -r us-south -g ibm-advocates-rg"
   2. get the cluster config for your cluster, e.g. "ibmcloud ks cluster config --cluster &lt;account&gt;_iks_cluster_user&lt;usernumber&gt;",
   3. copy-paste the EXPORT command, e.g. "export KUBECONFIG=/root/.bluemix/plugins/container-service/clusters/&lt;account&gt;_iks_cluster_user&lt;usernumber&gt;/kube-config-dal10-&lt;account&gt;_iks_cluster_user&lt;usernumber&gt;.yml",
   4. verify you are connected: "kubectl version --short",
   
