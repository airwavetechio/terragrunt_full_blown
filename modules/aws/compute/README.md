## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.docker_gpu_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.docker_swarm_master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.docker_swarm_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_key_pair.worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_security_group.docker_swarm_master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.docker_swarm_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_ami"></a> [aws\_ami](#input\_aws\_ami) | AMI image used as machine operating system | `map` | <pre>{<br>  "centos": "CentOS Linux 7 x86_64 HVM EBS ENA 1901_01-b7ee8a69-ee97-4a49-9e68-afaee216db2e-ami*",<br>  "ubuntu": "ubuntu-minimal/images/hvm-ssd/ubuntu-bionic-18.04-amd64-minimal-*"<br>}</pre> | no |
| <a name="input_aws_ami_owner"></a> [aws\_ami\_owner](#input\_aws\_ami\_owner) | n/a | `map` | <pre>{<br>  "centos": "679593333241",<br>  "ubuntu": "099720109477"<br>}</pre> | no |
| <a name="input_docker_gpu_worker_disk_size_gb"></a> [docker\_gpu\_worker\_disk\_size\_gb](#input\_docker\_gpu\_worker\_disk\_size\_gb) | The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. | `number` | `500` | no |
| <a name="input_docker_swarm_master_disk_size_gb"></a> [docker\_swarm\_master\_disk\_size\_gb](#input\_docker\_swarm\_master\_disk\_size\_gb) | The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. | `number` | `100` | no |
| <a name="input_docker_swarm_master_public_key"></a> [docker\_swarm\_master\_public\_key](#input\_docker\_swarm\_master\_public\_key) | An ssh public key for the admin user | `any` | n/a | yes |
| <a name="input_docker_swarm_master_sg"></a> [docker\_swarm\_master\_sg](#input\_docker\_swarm\_master\_sg) | Security group ingress for the docker swarm masters | `list(map(any))` | `[]` | no |
| <a name="input_docker_swarm_master_sg_egress"></a> [docker\_swarm\_master\_sg\_egress](#input\_docker\_swarm\_master\_sg\_egress) | Security group egress for the docker swarm masters | `list(map(any))` | `[]` | no |
| <a name="input_docker_swarm_worker_disk_size_gb"></a> [docker\_swarm\_worker\_disk\_size\_gb](#input\_docker\_swarm\_worker\_disk\_size\_gb) | The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. | `number` | `250` | no |
| <a name="input_docker_swarm_worker_public_key"></a> [docker\_swarm\_worker\_public\_key](#input\_docker\_swarm\_worker\_public\_key) | An ssh public key for the admin user | `any` | n/a | yes |
| <a name="input_docker_swarm_worker_sg"></a> [docker\_swarm\_worker\_sg](#input\_docker\_swarm\_worker\_sg) | Security group ingress for the docker swarm workers | `list(map(any))` | `[]` | no |
| <a name="input_docker_swarm_worker_sg_egress"></a> [docker\_swarm\_worker\_sg\_egress](#input\_docker\_swarm\_worker\_sg\_egress) | Security group egress for the docker swarm workers | `list(map(any))` | `[]` | no |
| <a name="input_gpu_shape"></a> [gpu\_shape](#input\_gpu\_shape) | n/a | `string` | `"demo"` | no |
| <a name="input_gpu_shapes"></a> [gpu\_shapes](#input\_gpu\_shapes) | n/a | `map` | <pre>{<br>  "constrained": {<br>    "pool_production_replicas": 1,<br>    "pool_production_units": 7,<br>    "pool_training_replicas": 1,<br>    "pool_training_units": 1<br>  },<br>  "demo": {<br>    "pool_production_replicas": 1,<br>    "pool_production_units": 3,<br>    "pool_training_replicas": 1,<br>    "pool_training_units": 1<br>  },<br>  "full": {<br>    "pool_production_replicas": 1,<br>    "pool_production_units": 10,<br>    "pool_training_replicas": 6,<br>    "pool_training_units": 6<br>  }<br>}</pre> | no |
| <a name="input_is_suspended"></a> [is\_suspended](#input\_is\_suspended) | Are the VMs slated for deletion | `bool` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The regional location of your Azure environemnt | `string` | `"East US"` | no |
| <a name="input_operatingsystem"></a> [operatingsystem](#input\_operatingsystem) | The Operating System of the virtual machines. | `string` | `"ubuntu"` | no |
| <a name="input_airwave_size"></a> [airwave\_size](#input\_airwave\_size) | The size of airwave cluster | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The name postfix that will be added to all resources | `string` | `"dev"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet ID of your aws environment | `string` | n/a | yes |
| <a name="input_swarm_gpu_worker_flavor"></a> [swarm\_gpu\_worker\_flavor](#input\_swarm\_gpu\_worker\_flavor) | n/a | `map` | <pre>{<br>  "fast_solo": "g4dn.xlarge",<br>  "moderate_few": "g4dn.xlarge",<br>  "moderate_solo": "g4dn.xlarge",<br>  "slow_few": "g4dn.xlarge"<br>}</pre> | no |
| <a name="input_swarm_manager_count"></a> [swarm\_manager\_count](#input\_swarm\_manager\_count) | n/a | `map` | <pre>{<br>  "fast_solo": 3,<br>  "moderate_few": 3,<br>  "moderate_solo": 3,<br>  "slow_few": 3<br>}</pre> | no |
| <a name="input_swarm_manager_flavor"></a> [swarm\_manager\_flavor](#input\_swarm\_manager\_flavor) | n/a | `map` | <pre>{<br>  "fast_solo": "m5.large",<br>  "moderate_few": "m5.large",<br>  "moderate_solo": "m5.large",<br>  "slow_few": "m5.large"<br>}</pre> | no |
| <a name="input_swarm_worker_count"></a> [swarm\_worker\_count](#input\_swarm\_worker\_count) | n/a | `map` | <pre>{<br>  "fast_solo": 1,<br>  "moderate_few": 3,<br>  "moderate_solo": 1,<br>  "slow_few": 3<br>}</pre> | no |
| <a name="input_swarm_worker_flavor"></a> [swarm\_worker\_flavor](#input\_swarm\_worker\_flavor) | n/a | `map` | <pre>{<br>  "fast_solo": "c5.18xlarge",<br>  "moderate_few": "m4.10xlarge",<br>  "moderate_solo": "m4.10xlarge",<br>  "slow_few": "r5.2xlarge"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id where compute machines will be provisioned | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Aws availability zone where nodes should be deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_docker_gpu_workers_all"></a> [docker\_gpu\_workers\_all](#output\_docker\_gpu\_workers\_all) | n/a |
| <a name="output_docker_swarm_masters_all"></a> [docker\_swarm\_masters\_all](#output\_docker\_swarm\_masters\_all) | n/a |
| <a name="output_docker_swarm_masters_private_ip_address"></a> [docker\_swarm\_masters\_private\_ip\_address](#output\_docker\_swarm\_masters\_private\_ip\_address) | n/a |
| <a name="output_docker_swarm_workers_all"></a> [docker\_swarm\_workers\_all](#output\_docker\_swarm\_workers\_all) | n/a |
