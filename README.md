# Provisioning of VPC and EC2 resources with Terraform IAC 

## VPC resources

- VPC with CIDR block 10.0.0.0/16
- 3 public subnets across different availability zones within the VPC
  
  | Subnet | Hosts |
  | ------------- | ------------- |
  | 10.0.0.0/18  | 16382 |
  | 10.0.64.0/18  | 16382  |
  | 10.0.128.0/19  | 8190  |
    
- 3 private subnets across different availability zones within the VPC
  
  | Subnet | Hosts |
  | ------------- | ------------- |
  | 10.0.128.0/19  | 8190 |
  | 10.0.192.0/19  | 8190  |
  | 10.0.224.0/19  | 8190  |
  
- Internet gateway
- NAT gateways
- Elastic IP's
- Route tables
- Route table associations


## EC2 resources
- Instance with bootstrap user data (nginx install)
- Security group with SSH an HTTP ports opened

## Structure
For simplicity, reusability and flexibility, the code has been separated into 4 files:
- [terraform.tf](https://github.com/gregoryoffodum/VPC_EC2_IAC/blob/master/VPC/terraform.tf): terraform configuration
- [provider.tf](https://github.com/gregoryoffodum/VPC_EC2_IAC/blob/master/VPC/povider.tf): provider details
- [main.tf](https://github.com/gregoryoffodum/VPC_EC2_IAC/blob/master/VPC/main.tf): resources to provision
- [variables.tf](https://github.com/gregoryoffodum/VPC_EC2_IAC/blob/master/VPC/variables.tf): variables file


## Assumptions
- Terraform has been installed on your machine/EC2 instance compatible with version in [terraform block](https://github.com/gregoryoffodum/VPC_EC2_IAC/blob/master/VPC/terraform.tf) (I have configured the version to work with the one already installed in my VM). To confirm version:

```
terraform --version
```
- One AWS authentication method has been implemented: access and secret keys/IAM role/profile.
- Key pair has been generated for EC2 resource and _key_name_ updated in [main.tf](https://github.com/gregoryoffodum/VPC_EC2_IAC/blob/master/VPC/main.tf) accordingly.

## Usage

- Clone repository
```
git clone https://github.com/gregoryoffodum/VPC_EC2_IAC.git
```
- Initialize backend and provider plugins:
  
```
terraform init
```

- Confirm resources to be added:

```
terraform plan 
```
- Apply each module:
```
terraform apply
```
