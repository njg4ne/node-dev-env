#! /bin/bash
eval `ssh-agent -s` > /dev/null;
ssh-add $1 > /dev/null;

# Route this command's standard error to a variable
ssh_output=$(ssh -T git@github.com 2>&1)

# Output based on whether the message contains successsfull
if [[ $ssh_output == *"successfull"* ]]; then
  echo "Auth Success!"
  else
  echo "Auth Failure!"
fi