## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.74.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.subdomain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cname_records"></a> [cname\_records](#input\_cname\_records) | A list of record names | `list(string)` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | The base domain for this zone | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The subdomain or host name | `string` | n/a | yes |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | The DNS records TTL | `number` | `300` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_a_record_fqdn"></a> [dns\_a\_record\_fqdn](#output\_dns\_a\_record\_fqdn) | n/a |
| <a name="output_dns_a_record_id"></a> [dns\_a\_record\_id](#output\_dns\_a\_record\_id) | n/a |
| <a name="output_dns_a_zone_id"></a> [dns\_a\_zone\_id](#output\_dns\_a\_zone\_id) | zone id |
