#outside the infra-app folder
module "dev-infra" {
    source = "./infra-app"
    env = "dev"
    bucket_name = "infra-app-bucket-d"
    instance_count = 1
    instance_type = "t3.micro"
    ec2_ami_id = "ami-0ced6a024bb18ff2e"
    hash_key = "studentID"
}

module "prod-infra" {
    source = "./infra-app"
    env = "prod"
    bucket_name = "infra-app-bucket-p"
    instance_count = 1
    instance_type = "t3.micro"
    ec2_ami_id = "ami-0ced6a024bb18ff2e"
    hash_key = "studentID"
}
