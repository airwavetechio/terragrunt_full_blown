plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

#Enables module inspection
config {
    module = true
    force = false
}

# Disallow // comments in favor of #.
rule "terraform_comment_syntax" {
    enabled = false
}
 
# Disallow output declarations without description.
rule "terraform_documented_outputs" {
    enabled = true
}
 
# Disallow variable declarations without description.
rule "terraform_documented_variables" {
    enabled = true
}
 

# Enforces naming conventions
rule "terraform_naming_convention" {
    enabled = true
    
    #Require specific naming structure
    variable {
    format = "snake_case"
    }
    
    locals {
    format = "snake_case"
    }
    
    output {
    format = "snake_case"
    }
    
    #Allow any format
    resource {
    format = "none"
    }
    
    module {
    format = "none"
    }
    
    data {
    format = "none"
    }
}
 
# Ensure that a module complies with the Terraform Standard Module Structure
rule "terraform_standard_module_structure" {
    enabled = true
}
