resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_c
  tags = {
    Project = "demo-assignment"
    Name    = var.vpc_name_c
  }
}

#================================================
# Create Public Subnet1
#================================================
resource "aws_subnet" "pub_sub1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sub1_cidr_block_c
  availability_zone       = var.zone_a_c
  map_public_ip_on_launch = true
  tags = {
    Project = "demo-assignment"
    Name    = "public_subnet1"
  }
}
#=======================================
# Create Public Subnet2
#======================================
resource "aws_subnet" "pub_sub2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sub2_cidr_block_c
  availability_zone       = var.zone_b_c
  map_public_ip_on_launch = true
  tags = {
    Project = "demo-assignment"
    Name    = "public_subnet2"
  }
}


#========================================
# Create Private Subnet1
#==========================================
resource "aws_subnet" "prv_sub1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.prv_sub1_cidr_block_c
  availability_zone       = var.zone_a_c
  map_public_ip_on_launch = false
  tags = {
    Project = "demo-assignment"
    Name    = "private_subnet1"
  }
}
#===============================================
# Create Private Subnet2
#==============================================
resource "aws_subnet" "prv_sub2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.prv_sub2_cidr_block_c
  availability_zone       = var.zone_b_c
  map_public_ip_on_launch = false
  tags = {
    Project = "demo-assignment"
    Name    = "private_subnet2"
  }
}

#================================================
# create  internetgateway
#===============================================

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id


  tags = {
    Project = "demo-assignment"
    Name    = "vault-igw"
  }
}



#=================================================
# Create Public Route Table
#=================================================
resource "aws_route_table" "pub_sub1_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Project = "demo-assignment"
    Name    = "public subnet route table"
  }
}
#========================================================
# Create route table association of public subnet1
#========================================================
resource "aws_route_table_association" "internet_for_pub_sub1" {
  route_table_id = aws_route_table.pub_sub1_rt.id
  subnet_id      = aws_subnet.pub_sub1.id
}
#===========================================================
# Create route table association of public subnet2
#==========================================================
resource "aws_route_table_association" "internet_for_pub_sub2" {
  route_table_id = aws_route_table.pub_sub1_rt.id
  subnet_id      = aws_subnet.pub_sub2.id
}


#=============================================================
# Create EIP for NAT GW1  
#=============================================================
resource "aws_eip" "eip_natgw1" {
  count = "1"
}
#===============================================================
# Create NAT gateway1
#==============================================================
resource "aws_nat_gateway" "natgateway_1" {
  count         = "1"
  allocation_id = aws_eip.eip_natgw1[count.index].id
  subnet_id     = aws_subnet.pub_sub1.id
}
#=================================================================
# Create EIP for NAT GW2 
#================================================================
resource "aws_eip" "eip_natgw2" {
  count = "1"
}
#===============================================================
# Create NAT gateway2 
#==============================================================

resource "aws_nat_gateway" "natgateway_2" {
  count         = "1"
  allocation_id = aws_eip.eip_natgw2[count.index].id
  subnet_id     = aws_subnet.pub_sub2.id
}

#================================================================
# Create private route table for prv sub1
#================================================================
resource "aws_route_table" "prv_sub1_rt" {
  count  = "1"
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway_1[count.index].id
  }
  tags = {
    Project = "demo-assignment"
    Name    = "private subnet1 route table"
  }
}
#===========================================================
# Create route table association betn prv sub1 & NAT GW1
#===========================================================
resource "aws_route_table_association" "pri_sub1_to_natgw1" {
  count          = "1"
  route_table_id = aws_route_table.prv_sub1_rt[count.index].id
  subnet_id      = aws_subnet.prv_sub1.id
}
#============================================================
# Create private route table for prv sub2
#===========================================================
resource "aws_route_table" "prv_sub2_rt" {
  count  = "1"
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway_2[count.index].id
  }
  tags = {
    Project = "demo-assignment"
    Name    = "private subnet2 route table"
  }
}
#==========================================================
# Create route table association betn prv sub2 & NAT GW2
#==========================================================
resource "aws_route_table_association" "pri_sub2_to_natgw1" {
  count          = "1"
  route_table_id = aws_route_table.prv_sub2_rt[count.index].id
  subnet_id      = aws_subnet.prv_sub2.id
}


#=================================================================================
# Create security group for load balancer
#================================================================================
resource "aws_security_group" "elb_sg" {
  name        = var.sg_name_c
  description = var.sg_description_c
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"] # laptop ka pub ip
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    #  ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = var.sg_tagname_c
    Project = "demo-assignment"
  }
}
#=====================================
# Create security group for webserver
#=====================================
resource "aws_security_group" "webserver_sg" {
  name        = var.sg_ws_name_c
  description = var.sg_ws_description_c
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"] #pvt subnet cidr
  }

  ingress {
    from_port   = 8201
    to_port     = 8201
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"] #pvt subnet cidr 
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"] #jump pub sunet cidr
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name    = var.sg_ws_tagname_c
    Project = "demo-assignment"
  }
}



#==========================================================
# Create Target group
#=========================================================
resource "aws_lb_target_group" "TG-tf" {
  name       = "Demo-TargetGroup-tf"
  depends_on = [aws_vpc.main]
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.main.id
  health_check {
    interval            = 60
    path                = "/ui/vault"
    port                = 8200
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 30
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}


#===============================================================
# Create ALB
#==============================================================

resource "aws_lb" "ALB-tf" {
  name               = "Demo-ALG-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [aws_subnet.pub_sub1.id, aws_subnet.pub_sub2.id]
  tags = {
    name    = "Demo-AppLoadBalancer-tf"
    Project = "demo-assignment"
  }
}
#==================================================================
# Create ALB Listener
#==================================================================
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ALB-tf.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG-tf.arn
  }
}


#================================================================
#create ec2 instance pvt-1
#================================================================

resource "aws_instance" "hashi_corp_vault" {

  count                  = "2"
  ami                    = var.ami_c
  instance_type          = var.instance_type_c
  key_name               = var.key_pair_c
  subnet_id              = aws_subnet.prv_sub1.id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  # root_block_device {
  # delete_on_termination = true
  # iops                  = 150
  # volume_size           = 25
  #  volume_type           = "gp2"
  # }
  tags = {
    Name = "vault-2"
  }
}


#======================================================================
#create ec2 instance pvt-2
#======================================================================
resource "aws_instance" "hashi_corp_vault_1" {

  count                  = "1"
  ami                    = var.ami_c
  instance_type          = var.instance_type_c
  key_name               = var.key_pair_c
  subnet_id              = aws_subnet.prv_sub2.id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]

  tags = {
    Name = "vault-1"
  }
}




#======================================================================
#create ec2 instance pub-1
#======================================================================
resource "aws_instance" "hashi_corp_vault_2" {

  count                  = "1"
  ami                    = var.ami_c
  instance_type          = var.instance_type_c
  key_name               = var.key_pair_c
  subnet_id              = aws_subnet.pub_sub2.id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]

  tags = {
    Name = "bastion-host"
  }
}




#==============================================================================
# Target Group Attachment with Instance
#==============================================================================

#resource "aws_alb_target_group_attachment" "tgattachment" {
#  count            = length(aws_instance.hashi_corp_vault_1.*.id, aws_instance.hashi_corp_vault.*.id)
#  target_group_arn = aws_lb_target_group.TG-tf.arn
#  target_id        = element(aws_instance.hashi_corp_vault_1.*.id, count.index , aws_instance.hashi_corp_vault.id )

  #target_id = ["aws_instance.hashi_corp_vault.id"]
#}

