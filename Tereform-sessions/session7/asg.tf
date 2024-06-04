resource "aws_launch_template" "main" {
  name = replace(local.Name, "rtype", "lc")
    image_id = data.aws_ami.amazon_linux_2023.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2.id]

  tag_specifications {
    resource_type = "instance"

    tags = merge(
        {Name = replace(local.Name, "rtype", "lc")}, 
        local.common_tags
      )
  }

  user_data = filebase64("userdata.sh")
}

resource "aws_autoscaling_group" "main" {
  name                      = replace(local.Name, "rtype", "lc")
  max_size                  =3
  min_size                  = 2
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 2
  target_group_arns = [aws_lb_target_group.main.arn]
  launch_template {
    id = aws_launch_template.main.id
  }
  vpc_zone_identifier       = [aws_default_subnet.public_subnet_1.id, aws_default_subnet.public_subnet_2.id]

  dynamic tag {
    for_each = local.asg_tags
    content {
      
    
    key                 = tag.key
    value               = tag.value
    propagate_at_launch = true
  }
}
}