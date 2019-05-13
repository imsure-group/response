#!/bin/bash
REPO=$1
DOCKERFILE=$2
echo "Running deployment for container: $REPO"
docker build -t $REPO:$TAG -f $DOCKERFILE .
docker --version  
pip install awscli
export PATH=$PATH:/$HOME/.local/bin
eval $(aws ecr get-login --registry-ids $AWS_ACCOUNT_NUMBER --region eu-west-2 --no-include-email)
docker tag $REPO:$TAG $AWS_ACCOUNT_NUMBER.dkr.ecr.eu-west-2.amazonaws.com/$REPO:$TAG
docker push $AWS_ACCOUNT_NUMBER.dkr.ecr.eu-west-2.amazonaws.com/$REPO:$TAG