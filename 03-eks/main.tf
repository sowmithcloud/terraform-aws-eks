module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "roboshop-tf"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  vpc_id                   = data.aws_ssm_parameter.vpc_id.value
  subnet_ids               = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  control_plane_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)

  create_cluster_security_group = false
  cluster_security_group_id     = data.aws_ssm_parameter.cluster_sg_id.value

  create_node_security_group = false
  node_security_group_id     = data.aws_ssm_parameter.node_sg_id.value

  # the user which you used to create cluster will get admin access
  enable_cluster_creator_admin_permissions = true

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3.small"]
  }

  eks_managed_node_groups = {
    blue = {
      min_size      = 2
      max_size      = 10
      desired_size  = 2
      capacity_type = "SPOT"
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonElasticFileSystemFullAccess = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
      }
    }
    # green = {
    #   min_size      = 2
    #   max_size      = 10
    #   desired_size  = 2
    #   capacity_type = "SPOT"
    #   iam_role_additional_policies = {
    #     AmazonEBSCSIDriverPolicy          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    #     AmazonElasticFileSystemFullAccess = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
    #   }

    # }
  }

  tags = var.common_tags
}