# instructions
## connect to cluster
aws eks --region $(./terraform output region) update-kubeconfig  --name $(./terraform output cluster_name)

## backup yaml
./kubectl describe configmap aws-auth -n kube-system > aws-auth-managed.yaml

## add in outputs.tf
output "worker_iam_role_name" {
  value       = module.eks.worker_iam_role_name
}

## disable aws_auth in main.tf
manage_aws_auth = "false"

## add default value for map_roles in variables.tf
username = "system:node:{{EC2PrivateDNSName}}"

## differences
managed -> 49 resources
unmanaged -> 47 resources (incl. config_map and "null_resource" "wait_for_cluster")