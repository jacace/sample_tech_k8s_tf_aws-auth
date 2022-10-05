# instructions
## connect to cluster
aws eks --region $(./terraform output region) update-kubeconfig  --name $(./terraform output cluster_name)

## backup yaml
./kubectl describe configmap aws-auth -n kube-system > aws-auth-managed.yaml

## differences
managed -> 49 resources
unmanaged -> 47 resources (incl. config_map and "null_resource" "wait_for_cluster")