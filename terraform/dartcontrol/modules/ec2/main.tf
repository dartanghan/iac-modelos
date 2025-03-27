#####
# EC2 Autoscaling Group
#####

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-ecs-hvm-2023.*-x86_64"]
  }
  tags = {
    Unity = "${var.project_name}-ec2"
  }
}

resource "aws_security_group" "ecs_sg" {
    name = "${var.project_name}-ecs-sg"
    tags = {
        Unity = "${var.project_name}-ec2"
    }
}

resource "aws_launch_template" "ecs_launch_template" {
  name_prefix   = "${var.project_name}-ecs-"
  image_id      = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t2.micro"

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name  = "${var.project_name}-ecs"
      Unity = "${var.project_name}-ec2"
    }
  }

  metadata_options {
    http_tokens               = "required"
    http_put_response_hop_limit = 2
    http_endpoint             = "enabled"
  }
}

resource "aws_placement_group" "ecs_placement_group" {
  name     = "cluster"
  strategy = "cluster"
  tags = {
    Unity = "${var.project_name}-ec2"
  }
}

resource "aws_autoscaling_group" "asg_ecs" {
    name    = "${var.project_name}-ecs-asg"
    vpc_zone_identifier = [var.subnet_priv_a_id, var.subnet_priv_b_id]
    min_size = 1
    max_size = 2
    launch_template{
        id = aws_launch_template.ecs_launch_template.id
        version = "$Latest"
    }
    health_check_type = "EC2"
    health_check_grace_period = 300
    desired_capacity = 1
    force_delete = true
    placement_group = aws_placement_group.ecs_placement_group.name

    tag {
        key = "Name"
        value = "${var.project_name}-ecs"
        propagate_at_launch = true
    }
    tag {
        key = "Unity"
        value = "${var.project_name}-ec2"
        propagate_at_launch = true
    }
}

#####
# / EC2 Autoscaling Group
#####

