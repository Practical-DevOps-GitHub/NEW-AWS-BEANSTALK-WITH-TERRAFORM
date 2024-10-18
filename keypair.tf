resource "aws_key_pair" "teachua_app_key_2" {
  # key_name   = "new-eb-key"
  key_name   = "eb_key"
  public_key = file(var.PUB_KEY)
}
