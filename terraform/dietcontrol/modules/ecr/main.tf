resource "aws_ecr_repository" "ecr" {
    name = "${var.project_name}-ecr"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
      scan_on_push = true
    }    
    tags = {
        Unity = "${var.project_name}-ecs"
    }
}



#####
# LOADBALANCER
#####
resource "aws_alb" "ecs_alb" {
    name            = "${var.project_name}-ecs-alb"
    internal        = false
    load_balancer_type = "application"
    security_groups = [var.ec2_security_group_id]
    subnets         = [var.subnet_pub_a_id, var.subnet_pub_b_id]
    tags = {
        Unity = "${var.project_name}-ecs"
    }
}

#####
# / LOADBALANCER
#####

#####
# ECS Cluster
#####
resource "aws_ecs_cluster" "ecs" {
    name = "${var.project_name}-ecs"
    tags = {
        Name = "${var.project_name}-ecs"
        Unity = "${var.project_name}-ecs"
    }
}

# resource "aws_ecs_service" "ecs_service" {
#     name            = "${var.project_name}-ecs-service"
#     cluster         = aws_ecs_cluster.ecs.id
#     task_definition = aws_ecs_task_definition.ecs_task_definition.arn
#     desired_count   = 1
#     launch_type     = "EC2"

#     network_configuration {
#         subnets          = [var.subnet_priv_a_id, var.subnet_priv_b_id]
#         security_groups  = [aws_security_group.ecs_sg.id]
#         assign_public_ip = false
#     }

#     load_balancer {
#         target_group_arn = aws_lb_target_group.ecs_target_group.arn
#         container_name   = "nginx"
#         container_port   = 80
#     }

#     depends_on = [aws_ecs_cluster.ecs]
# }