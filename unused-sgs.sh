#!/bin/bash

function in_array() {
    local hay needle=$1
    shift
    for hay; do
        [[ $hay == $needle ]] && return 0
    done
    return 1
}

## defaults
AWS_PROFILE="--profile ${1:-default}"
AWS_REGION="--region ${2:-us-east-1}"


json_all_sgs=$(aws ec2 describe-security-groups $AWS_PROFILE $AWS_REGION)
arr_all_sgs_ids=($(echo $json_all_sgs | jq --raw-output '.SecurityGroups[].GroupId'))
arr_used_sgs_ids=($(aws ec2 describe-network-interfaces $AWS_PROFILE $AWS_REGION | jq --raw-output '.NetworkInterfaces[].Groups[].GroupId' | sort -u))

line='                          ->'

echo "########### Unnused SG's ###########"
for sg_id in "${arr_all_sgs_ids[@]}"
do
    in_array $sg_id "${arr_used_sgs_ids[@]}"
    if [ $? -eq 1 ]; then
        sg_name=$(echo $json_all_sgs  | jq --raw-output '.SecurityGroups[] | select(.GroupId == "'$sg_id'").GroupName')
		printf "%s %s $sg_name\n" $sg_id"${line:${#sg_id}}"
    fi
done
