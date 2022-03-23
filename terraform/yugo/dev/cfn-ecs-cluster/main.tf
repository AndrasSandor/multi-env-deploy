terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.70.0"
    }
  }
}

provider "aws" {
  profile = "yugo"
  region  = "ap-southeast-1"
  }


resource "aws_cloudformation_stack" "dev-ecs-cluster" {

  name                              = "dev-ecs-cluster-test"

  parameters    = {
    ParentVPCStack                          = "vpc-2az-dev"
    DrainingTimeoutInSeconds                = 60
    IAMUserSSHAccess                        = true
    InstanceType                            = "t2.micro"
    KeyName                       = "skp"
    LoadBalancerCertificateArn    = "arn:aws:acm:ap-southeast-1:002724113606:certificate/b440669a-84ab-41d0-ac33-7d4e85b7da78"
    LoadBalancerIdleTimeout       = 60
    LoadBalancerScheme            = "internet-facing"
    LogsRetentionInDays           = 14
    ManagedPolicyArns             = ""
    MaxSize                       = 2
    MinSize                       = 2
    ParentAlertStack              = "alert"
    ParentAuthProxyStack          = ""
    ParentClientStack1            = ""
    ParentClientStack2            = ""
    ParentClientStack3            = ""
    ParentS3StackAccessLog        = "dev-alb-logs-s3-bucket"
    ParentSSHBastionStack         = "ssh-bastion"
    PermissionsBoundary           =""
    StopContainerTimeoutInSeconds = 30
    SubnetsReach                  = "Public"
    SystemsManagerAccess          = true
 
  }
  template_url  = "./dev-client-service-cluster-alb.yml"
  
  tags = {
    env     = "dev"
  } 

}