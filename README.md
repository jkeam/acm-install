# ACM Installation
ACM installation documentation.

## Installation
Reference can be found [here](https://access.redhat.com/documentation/en-us/red_hat_advanced_cluster_management_for_kubernetes/2.6/html/install/installing#installing-from-the-cli).

### With Infranodes
If you have infranodes and want to use them, awesome.  Make sure the following are set, but also look at the section below with no Infranodes for additional instructions.

1.  Ensure your infranodes are setup. Your nodes should have:
```
metadata:
  labels:
    node-role.kubernetes.io/infra: ""
spec:
  taints:
  - effect: NoSchedule
    key: node-role.kubernetes.io/infra
```

2.  When installing ACM, make sure the following is setup so that ACM uses the infranodes from above
```
spec:
  config:
    nodeSelector:
      node-role.kubernetes.io/infra: ""
    tolerations:
    - key: node-role.kubernetes.io/infra
      effect: NoSchedule
      operator: Exists
```

3.  When creating a MultiClusterHub, make sure the following is set:
```
spec:
  nodeSelector:
    node-role.kubernetes.io/infra: ""
```

### General Installation Instructions
These are the actual instructions.  Will still follow these steps regardless of infranodes or not.

1.  Create namespace
```
oc create open-cluster-management
```

2.  Create operator group
```
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  name: open-cluster-management-62tgm
spec:
  targetNamespaces:
  - open-cluster-management
```

3.  Create subscription
```
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: acm-operator-subscription
spec:
  sourceNamespace: openshift-marketplace
  source: redhat-operators
  channel: release-2.6
  installPlanApproval: Automatic
  name: advanced-cluster-management
```

4.  Create MultiClusterHub
```
apiVersion: operator.open-cluster-management.io/v1
kind: MultiClusterHub
metadata:
  name: multiclusterhub
  namespace: open-cluster-management
spec: {}
```

5.  Wait for `Running`
```
oc get mch -o=jsonpath='{.items[0].status.phase}'
```

6.  Find URL to login
```
oc get routes
```

### Easy Installation
Just run my script.

```
./install.sh
```

### Easy Uninstall
Just run my script.

```
./uninstall.sh
```
