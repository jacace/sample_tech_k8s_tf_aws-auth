variable "region" {
  default = "us-west-2"
}	

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {

      rolearn  = "arn:aws:iam::66666666666:role/rolearn"
      //rolearn  = var.worker_iam_role_name
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:bootstrappers", "system:nodes"]
    }      
  ]
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::66666666666:user/user1"
      username = "user1"
      groups   = ["system:masters"]
    }     
  ]
}

variable "aws_eks_cluster_endpoint" {
  type = string
  default = "https://abc.region.eks.amazonaws.com"
}

variable "aws_eks_cluster_name" {
  type = string
  default = ""
}

variable "certificate_authority_data" {
  type = string
  default = ""
}