# Usage:
#  $ ./getIp.sh param1 param2
# * param1: Name of the AutoScaling Group
# * param2: Path to pem file

if [ "$#" -ne 2 ]; then
    echo "Invalid number of parameters"
    exit
fi

sed -i '/\[servers\:vars\]/,$!d' hosts

instances=($(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name $1 | grep -i instanceid  | awk '{ print $2}' |tr -d ',"'))
for instance in "${instances[@]}"; do
    ip=$(aws ec2 describe-instances --instance-ids $instance | grep -iw PublicIpAddress | awk '{ print $2 }' | tr -d ',"\n')
    temp="$ip ansible_user=ubuntu ansible_ssh_private_key_file=$2"
    awk -v temp="$temp" inplace 'BEGINFILE{print temp}{print}' hosts
done

sed -i '1s/^/[servers]\n/' hosts


ansible-playbook -i hosts main.yml
