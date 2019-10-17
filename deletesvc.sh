#!/bin/bash
kubectl delete ing terminal-ingress
echo Scrubbing Docker...
kubectl create -f scrub-dind.yaml
sleep 15s
kubectl delete -f scrub-dind.yaml
echo How many instances are you wiping clean?
read instances
for ((i=1; i<=$instances; i++))
do
   echo "deleting terminal $i"
   kubectl delete svc terminal-service-$i
   kubectl delete svc external-service-3000-$i
   kubectl delete svc external-service-5000-$i
   kubectl delete svc external-service-8080-$i
   kubectl delete svc external-service-8081-$i
   kubectl delete deployment terminal-$i
done
