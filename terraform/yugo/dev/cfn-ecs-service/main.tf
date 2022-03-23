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


resource "aws_cloudformation_stack" "dev-client-service" {

  name                              = "dev-client-service"

  parameters    = {
    ParentClusterStack              = dev-ecs-cluster
    ParentAlertStack                = alert
    AutoScaling                     = false
    DesiredCount                    = 1
    HealthCheckGracePeriod          = 10
    Image                           = "002724113606.dkr.ecr.ap-southeast-1.amazonaws.com/dev-client-repo:latest"
    LoadBalancerDeregistrationDelay = 5
    LoadBalancerHostPattern         = "book.yugo.tech"
    LoadBalancerPriority            = 100
    LoadBalancerHostPattern2        = "yugo.tech"
    LoadBalancerPriority2           = 109
    LoadBalancerHttps               = true
    LoadBalancerPath                = ""
    MinCapacity                     = 1
    MaxCapacity                     = 3
    ParentZoneStack                 = ""
    PermissionsBoundary             = ""
    SubDomainNameWithDot            = ""
  }
  template_url  = "./dev-client-service-cluster-alb.yml"
  
  tags = {
    env     = "dev"
  } 

}