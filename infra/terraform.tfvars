vpc_cidr             = "10.0.0.0/16"
vpc_name             = "dev-proj-vpc"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet  = ["10.0.3.0/24", "10.0.4.0/24"]
eu_availability_zone = ["eu-central-1a", "eu-central-1b"]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHPaokDq9Z0b3CtPRUuhdig8soFN1rTbCxIhaX6K6rgGj9sQrDL4kiCTp85kgfFUARjZtKlO5bfmXFKneQX0QTcS17LycoEQnMtvntN+lsMtD3N46FC2fo94s+kPIBILidTzpUMqThbKeEoPnuhU2VKH8nJGaTI+aOAKz6N8mpCbW15cnmdAcI3/6dxbN9hXOmKXgvtOYdGevR90xtOUwwiLwruEq51glR0RyBQAxM4TE41+Hwna4EjVz0a6n/udJZyGzGE7HIoeCJLwMxhHqg1TJJ6czIQyy7KXocZv7kQd4zjR7AN2ppt63hjIO7UH49pxaRHaFforLKm8czFMTI7jYRn8JMQp/EMk1l4VJZYFBXelv2TlLOQkLk1fpWdAOdHLyf+lllu1ERqGlLuSIThbOM0YZaFx0RXnNLil/ZlgCZzv9aIHfg/HkKyJRtx8ODJO49/N86tE0B44ZZsAbTKeu1VVCwY6r81oVzKy98sFDQhpDc6uRlvk1aL3AddSM= BADR@DESKTOP-E4I2M8E"
ec2_ami_id     = "ami-0faab6bdbac9486fb"

ec2_user_data_install_apache = ""