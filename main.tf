
module "aws_instance" {

  source        = "./modules/test"
  myTag         = var.myTag
  instance_type = var.instance_type

}
