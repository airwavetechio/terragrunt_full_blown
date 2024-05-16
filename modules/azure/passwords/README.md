## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_password.database_user_passwords](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.keycloak_login_server_client_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.keycloak_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.minio_secret_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.airwave_realm_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.postgres_admin_passwords](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_databases"></a> [databases](#input\_databases) | n/a | `list` | <pre>[<br>  {<br>    "instance": "analysis",<br>    "name": "analysis"<br>  },<br>  {<br>    "instance": "general",<br>    "name": "core"<br>  },<br>  {<br>    "instance": "general",<br>    "name": "ingest"<br>  },<br>  {<br>    "instance": "general",<br>    "name": "keycloak"<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_user_passwords"></a> [database\_user\_passwords](#output\_database\_user\_passwords) | Postgres Database User Passwords |
| <a name="output_keycloak_login_server_client_secret"></a> [keycloak\_login\_server\_client\_secret](#output\_keycloak\_login\_server\_client\_secret) | Keycload Login Server Client Secret |
| <a name="output_keycloak_password"></a> [keycloak\_password](#output\_keycloak\_password) | Keycload Password |
| <a name="output_minio_secret_key"></a> [minio\_secret\_key](#output\_minio\_secret\_key) | Minio Secret Key |
| <a name="output_airwave_realm_admin_password"></a> [airwave\_realm\_admin\_password](#output\_airwave\_realm\_admin\_password) | Pienso Realm Admin Password |
| <a name="output_postgres_admin_passwords"></a> [postgres\_admin\_passwords](#output\_postgres\_admin\_passwords) | Postgres Admin Passwords |
