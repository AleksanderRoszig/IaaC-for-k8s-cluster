# IaaC-for-k8s-cluster-AWS

IaaC in Terraform for new kubernetes cluster on AWS EC2 instances. AMI that's image with Ubuntu 20.04 where everything is preparded like on this page https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/. All you have to do on machines is kubeadm init --pod-network-cicdr <pod-network> --apiserver-advertise-address=<master_node_ip> and deploy CNI plugin. This infrastructure is for testing deploying kubernetes clusters. In security group for this VPC you have to add your IP address to be able to communicate via ssh to the EC2 instances.



How to start with Terraform for AWS
https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started
