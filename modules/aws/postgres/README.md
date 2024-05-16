## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.postgres_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.airwave](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.postgres](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.postgres](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_string.db_name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created. | `string` | `"postgres"` | no |
| <a name="input_administrator_password_list"></a> [administrator\_password\_list](#input\_administrator\_password\_list) | The password map associated with the administrator\_login for the PostgreSQL Server. | `map` | n/a | yes |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | Backup retention days for the server, supported values are between 7 and 35 days. | `number` | `7` | no |
| <a name="input_database_flavor"></a> [database\_flavor](#input\_database\_flavor) | n/a | `map(any)` | <pre>{<br>  "analysis": {<br>    "fast_solo": "db.m5.xlarge",<br>    "moderate_few": "db.m5.xlarge",<br>    "moderate_solo": "db.m5.xlarge",<br>    "slow_few": "db.m5.xlarge"<br>  },<br>  "general": {<br>    "fast_solo": "db.m5.large",<br>    "moderate_few": "db.m5.large",<br>    "moderate_solo": "db.m5.large",<br>    "slow_few": "db.m5.large"<br>  }<br>}</pre> | no |
| <a name="input_databases"></a> [databases](#input\_databases) | n/a | `list` | `[]` | no |
| <a name="input_max_storage_gb"></a> [max\_storage\_gb](#input\_max\_storage\_gb) | Max storage that server will use when autoscaled. | `number` | `20000` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | A suffix to the database name (optional) | `string` | `""` | no |
| <a name="input_airwave_postgres_sg"></a> [airwave\_postgres\_sg](#input\_airwave\_postgres\_sg) | Security group for the redis swarm masters | `list(map(any))` | <pre>[<br>  {<br>    "description": "postgres",<br>    "destination_port_range": "5432",<br>    "protocol": "Tcp",<br>    "source_address": "10.0.2.0/24",<br>    "source_port_range": "5432"<br>  }<br>]</pre> | no |
| <a name="input_airwave_size"></a> [airwave\_size](#input\_airwave\_size) | The size of airwave cluster | `string` | n/a | yes |
| <a name="input_server_version"></a> [server\_version](#input\_server\_version) | Specifies the version of PostgreSQL to use. Changing this forces a new resource to be created. | `string` | `"12.9"` | no |
| <a name="input_storage_gb"></a> [storage\_gb](#input\_storage\_gb) | Max storage allowed for a server. | `number` | `128` | no |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The name postfix that will be added to all resources | `string` | `"dev"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet which should have access to postgres database. | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id where compute machines will be provisioned | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Aws availability zone network will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_server_info"></a> [server\_info](#output\_server\_info) | n/a |
| <a name="output_server_name"></a> [server\_name](#output\_server\_name) | n/a |
