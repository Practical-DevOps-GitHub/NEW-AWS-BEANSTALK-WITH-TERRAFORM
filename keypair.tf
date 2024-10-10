resource "aws_key_pair" "teachua_app_key" {
  key_name   = "teachua-key-1"
  public_key = file(var.PUB_KEY)
}
