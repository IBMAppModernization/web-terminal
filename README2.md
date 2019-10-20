# Create a Classic Cluster

$ ibmcloud login -u .. -p ..
$ ibmcloud target --cf
$ ibmcloud target -g Default

$ ibmcloud ks zones
$ ibmcloud ks machine-types --zone dal10
$ ibmcloud ks cluster create classic --name test_iks_cluster_1 --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 
$ ibmcloud ks clusters
OK
Name                   ID                     State       Created         Workers   Location   Version       Resource Group Name   Provider   
test_iks_cluster_1   abcdef1g2h3i4j5klmn6   deploying   2 minutes ago   3         Dallas     1.14.7_1534   -                     classic

$ ibmcloud ks vlan ls --zone dal10
OK
ID        Name   Number   Type      Router         Supports Virtual Workers   
2730902          1593     private   abc01d.dal10   true   
2730900          1519     public    bcd01e.dal10   true   