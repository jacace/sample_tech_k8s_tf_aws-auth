terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.13.1"
    }
  }
}

provider "kubernetes" {
  #using exec as recommended -> https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs#exec-plugins
  host                   = var.aws_eks_cluster_endpoint
  cluster_ca_certificate = base64decode(var.certificate_authority_data)
  
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", var.aws_eks_cluster_name]
    command     = "aws"
  }
}

//resource "kubernetes_config_map_v1_data" "aws_auth" {
//  force = true
//  metadata {
//    name      = "aws-auth"
//    namespace = "kube-system"
//  }
//  data = {
//    mapUsers = yamlencode(var.map_users)
//  }
//}

resource "kubernetes_config_map_v1" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
     mapUsers = yamlencode(var.map_users)
     mapRoles = yamlencode(var.map_roles)
  }

  //binary_data = {
  //  "my_payload.bin" = "${filebase64("${path.module}/my_payload.bin")}"
  //}
}