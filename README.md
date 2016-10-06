# packer-ecs-ami

## Prerequisition
Setup AWS CLI on your local machine
## Build AMI
* Normal mode
```
packer build  -var 'build_region=us-west-2' -var 'user=ec2-user' -var 'source_ami=ami-562cf236' -var 'instance_type=c3.large' -var 'ami_name=test-amzn-ecs' -var 'scripts_dir=ecs_scripts' ecs.json
```
* Debug mode
```
packer build -debug -var 'build_region=us-west-2' -var 'user=ec2-user' -var 'source_ami=ami-562cf236' -var 'instance_type=c3.large' -var 'ami_name=test-amzn-ecs' -var 'scripts_dir=ecs_scripts' ecs.json
```
