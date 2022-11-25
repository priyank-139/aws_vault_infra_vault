# aws_vault_infra_vault
## terraform module for an AWS infra for deploying hashi corp vault cluster

```
In this terraform module I used 3 child modules i.e, vpc kms 

1- vpc module - 13 resources that created vpc , 3 pvt subnet ,1 public subnet (for bastion host)

2- kms module - 2 resources for auto unseal the vault tool 

```

