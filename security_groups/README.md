# Cleanup security groups

## Methodology
Methodology
This script lists all security groups attached to a network interface (this includes features like EC2, RDS, LB, Lambda, Elactic Cache etc) and then subtracts from the total list of available security groups thus resulting in the list of security groups that are not attached to any resource.

#### Requirements
To use this script it is necessary to have an AWS profile configured.

#### Parameters
- Parameter 1: aws profile, by default it uses the default profile, if you use a different profile, use this argument
- Parameter 2: aws region, by default it uses the us-east-1 region, if you use a different region use this argument

#### Exemple: 
`bash ./unused-sgs.sh xxxx us-east-2`

#### Output:
```
########### Unnused SG's ###########
sg-xxxxxxxx               ->  xxxxxxxxxxxxx
sg-xxxxxxxxxxxxxxxxx      ->  xxxxxxxxxxx
sg-xxxxxxxx               ->  xxxxx
sg-xxxxxxxxxxxxxxxxx      ->  xxxxxxxxxxxxxxx
sg-xxxxxxxxxxxxxxxxx      ->  xxxxxxxxx
sg-xxxxxxxxxxxxxxxxx      ->  xxxxxxxxx
```
