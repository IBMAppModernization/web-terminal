#!/bin/bash

# READ PROPERTIES
config_file="./init.properties"
if [ -f "$config_file" ]
then
  # Internal Field Separator (IFS) 
  while IFS='=' read -r key value
  do
    #key=$(echo $key | tr '.' '_')
	key=$(echo $key | tr .-/ _ | tr -cd 'A-Za-z0-9_')
    eval ${key}=\${value}
  done < "$config_file"
else  
  echo "$config_file not found."
fi

# DELETE SERVICE
for (( n=$user_offset;n<($number_of_users+$user_offset);n++ ))
do
    echo "delete event streams ${n}"
	
	yes | ibmcloud resource service-key-delete "${account_name}esuser${n}-credentials1" 
	
	yes | ibmcloud resource service-instance-delete "${account_name}esuser${n}" 

done