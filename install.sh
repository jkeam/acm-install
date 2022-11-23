#!/bin/bash

oc new-project open-cluster-management
sleep 1

oc create -f ./1_create_operator_group.yaml
oc create -f ./2_create_subscription.yaml
echo 'Installing operator, waiting for 2 minutes'
sleep 120

oc create -f ./3_create_multi_cluster_hub.yaml
echo 'Installing multi cluster hub, waiting for 10 minutes to be running'
sleep 600

echo 'State of multi cluster hub:'
oc get mch -o=jsonpath='{.items[0].status.phase}'
echo ''
echo ''
oc get routes -n open-cluster-management
