

Istio can only be enabled after the clusters are done being created. Because this can take a long time, I separated this part from the creation of clusters and services.

```console
$ sh init.sh
$ sh init-enable-istio.sh
```
