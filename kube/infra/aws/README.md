# Pienso, AWS and Terragrunt


## Directory structure
Since we are in AWS, `aws` is the `root` directory from a `terragrunt` perspective. The directory structure then breaks down by `region` > `environment name` > `NNN-module`. 

The prefix for each directory `NNN` is simply for human readability. If you look at the structure here, you'll see directories:

* 000-eip
* 001-vpc
* 002-eks
* 003-eks-addons

Not only does the OS list these in alphabetical order, but it gives you an idea of the order in which each module will be run. Again, it's only for human clarity and has no impact on the actual order of deploy when you run `terragrunt`. 

The order of deploy, or `dependencies`, are built into the `terragrunt.hcl` files within each of these directories. 


## Creating a new environment in a new region
In the first level subdirectory of the root, you should see a directory of a region. For example `us-west-2`. Copy this directory with the name of the region you are deploying to. Move to the section `Creating a new environment within a region`. THe region is set from the directory name. 

## Creating a new environment within a region
Drill down each subdirectory by region and then copy an existing environment. Within that environment directory, there should be 2 files 
* `environment.hcl`
* `terraform.tfvars`

Edit these 2 files with the values that make up your new environment. You then run `terragrunt` from this directory. You shouldn't have to touch anything else. 

## Getting the EKS config for kubectl
`aws eks update-kubeconfig --region <region> --name <cluster_name>`

# Troubleshooting

## Getting hit with annoying git safe directory messages?
Run `git config --global --add safe.directory "*"`

## Set Terragrunt paralleism
A lot can happen simulataenously. If you are constantly seeing plugin init timeouts or other odd behavior and you have enough compute, resources you should add the `--terragrunt-parallelism 1` flag. Read more about it here: https://terragrunt.gruntwork.io/docs/features/execute-terraform-commands-on-multiple-modules-at-once/


## Run only certain directories
Running everything at once takes a long time. If you just want to run Terraform within a certain directory, navigate the the right directory level and run `terragrunt run-all apply` with the `--terragrunt-exclude-dir` flag. Here's a real world example that will only run the Pienso stack. Find more info here: https://terragrunt.gruntwork.io/docs/reference/cli-options/#terragrunt-exclude-dir

* Example: `terragrunt run-all apply --terragrunt-exclude-dir 000-eip --terragrunt-exclude-dir 001-vpc --terragrunt-exclude-dir 002-eks`
