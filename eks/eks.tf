#EKS
# resource "aws_ebs_encryption_by_default" "enabled" {
#      enabled = true
# }

module "eks" {
  source                         = "git::git@github.com:Gtsaas123/terraform-aws-eks.git"
  cluster_name                   = "my-eks-cluster-gtsaas"
  cluster_version                = "1.30"
  cluster_endpoint_public_access = false
  cluster_endpoint_private_access = true
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets


  eks_managed_node_groups = {
    nodes = {
      ami_type = "AL2023_x86_64_STANDARD"
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      instance_types = ["t3.xlarge"]

      block_device_mappings = [
        {
          device_name = "/dev/xvda" # Root device
          ebs = {
            volume_size           = 20
            volume_type           = "gp3"
            delete_on_termination = true
            encrypted             = true
          }
        }
      ]
      #node_role = data.aws_iam_role.eks_worker_node.arn

      

      # volume_size = 50
      # volume_type = "gp3"
      # encrypted = true
      #node_volume_encrypted = true

      #asg = aws_autoscaling_group.template-autoscaling-group.id

      # launch_template = {
      #   id      = aws_launch_template.first-template.id
      #   version = "$Latest"
      # }

      #iam_role_arn = data.aws_iam_role.eks_worker_node.arn
    }
  }

  # self_managed_node_groups = {
  #   nodes = {
  #     ami_type      = "AL2_x86_64"
  #     instance_type = "t3.xlarge"

  #     min_size = 1
  #     max_size = 5
  #     # This value is ignored after the initial creation
  #     # https://github.com/bryantbiggs/eks-desired-size-hack
  #     desired_size = 3

  #     volume_size = 50
  #     volume_type = "gp3"
  #     encrypted = true
      
    
  #   }
    
  # }
  cluster_addons = {
    coredns            = {}
    kube-proxy         = {}
    vpc-cni            = {}
    aws-efs-csi-driver = {}
  }

  tags = {

    Terraform = "true"
  }

}

# module "eks_blueprints_addons" {
#   source = "aws-ia/eks-blueprints-addons/aws"
#   version = "~> 1.0" #ensure to update this to the latest/desired version

#   cluster_name      = module.eks.cluster_name
#   cluster_endpoint  = module.eks.cluster_endpoint
#   cluster_version   = module.eks.cluster_version
#   oidc_provider_arn = module.eks.oidc_provider_arn

#   eks_addons = {
#     aws-ebs-csi-driver = {
#       most_recent = true
#     }
#     coredns = {
#       most_recent = true
#     }
#     vpc-cni = {
#       most_recent = true
#     }
#     kube-proxy = {
#       most_recent = true
#     }
#   }

#   enable_aws_load_balancer_controller    = true
#   enable_kube_prometheus_stack           = true
#   enable_metrics_server                  = true

#   tags = {
#     Environment = "poc"
#   }
# }

