variable "aws_eip_count" {
    type = number
    description = "The number of EIPs you need"
}


variable "tags" {
  description = "A map of tags to set on every taggable resources. Empty by default."
  type        = map(string)
  default     = {}
}