# EC2 Module - Compute Infrastructure
module "ec2" {
  source = "../../../modules/ec2"

  project_name        = var.project_name
  environment         = var.environment
  ami                 = var.ami
  instance_type       = var.instance_type
  vpc_id              = data.terraform_remote_state.network.outputs.vpc_id
  public_subnet_ids   = data.terraform_remote_state.network.outputs.public_subnet_ids
  private_subnet_ids  = data.terraform_remote_state.network.outputs.private_subnet_ids
  ssh_public_key_path = "../key.pub"
}
