# Output cho master node
output "master_public_ip" {
  description = "Public IP of Kubernetes master node"
  value       = aws_instance.k8s_nodes[0].public_ip
}

output "master_private_ip" {
  description = "Private IP of Kubernetes master node"
  value       = aws_instance.k8s_nodes[0].private_ip
}

# Output cho worker nodes
output "worker_public_ips" {
  description = "Public IPs of Kubernetes worker nodes"
  value       = [for node in aws_instance.k8s_nodes : node.public_ip if node.tags["Role"] == "worker"]
}

output "worker_private_ips" {
  description = "Private IPs of Kubernetes worker nodes"
  value       = [for node in aws_instance.k8s_nodes : node.private_ip if node.tags["Role"] == "worker"]
}

# Output cho Jenkins node
output "jenkins_public_ip" {
  description = "Public IP of Jenkins node"
  value       = aws_instance.jenkins_node.public_ip
}

output "jenkins_private_ip" {
  description = "Private IP of Jenkins node"
  value       = aws_instance.jenkins_node.private_ip
}