#!/bin/bash

oc delete -f ./3_create_multi_cluster_hub.yaml
echo 'Deleting multi cluster hub, waiting for 10 minutes'
sleep 600

oc delete -f ./2_create_subscription.yaml
oc delete -f ./1_create_operator_group.yaml
oc delete project open-cluster-management
