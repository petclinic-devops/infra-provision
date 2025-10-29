# Security group cho toàn bộ hạ tầng
resource "aws_security_group" "infra_sg" {
  name        = "infra-sg"
  description = "Allow SSH and necessary ports"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "infra-sg"
  }
}

# Tạo 3 máy cho Kubernetes cluster: 1 master, 2 worker
resource "aws_instance" "k8s_nodes" {
  count                  = var.k8s_node_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.infra_sg.id]

  # Cấu hình dung lượng ổ đĩa cho K8s nodes
  root_block_device {
    volume_size = var.k8s_volume_size   # Dung lượng GB
    volume_type = "gp3"                 # SSD mới, nhanh hơn gp2
    delete_on_termination = true
  }

  tags = {
    Name = count.index == 0 ? "master-node" : "worker-node-${count.index}"
    Role = count.index == 0 ? "master" : "worker"
  }
}


# Tạo 1 máy riêng cho Jenkins + Ansible + Runner
resource "aws_instance" "jenkins_node" {
  ami                    = var.ami_id
  instance_type          = var.jenkins_instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.infra_sg.id]

  # Cấu hình dung lượng ổ đĩa cho Jenkins node
  root_block_device {
    volume_size = var.jenkins_volume_size
    volume_type = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "jenkins-node"
    Role = "jenkins"
  }
}