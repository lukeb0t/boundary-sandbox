Terraform workspace for laying down the initial controller configuration of a Hashicorp Boundary instance and cooresponding Hashicorp Vault.

---
Instructions
---
  - I already have a boundary and Vault instance to use:
The terraform module in the root of the repo can be executed against existing, clean, Vault and Boundary instances if they are already provisioned. You will need to update the connection information in main.tf. 
  - I want to stand up clean instances of Vault and Boundary:
The demo-infra contains a terraform module for standing up the necessary Vault and Boundary infrastructure via Docker desktop. This requires docker desktop, and has only been tested with OSX. Once the infrastructure has been provisioned, the main module in the root of the repo will handle the rest of the deployment. 

