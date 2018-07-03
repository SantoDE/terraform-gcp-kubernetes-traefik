# Traefik on Google Cloud Kubernetes Engine

## Requirements
* Google Cloud Account
* gcloud SDK installed
* GCP Project with Billing and Compute Engine Enabled

## Steps

### Setup CLI
```
gcloud init
gcloud auth application-default login
export GOOGLE_PROJECT=$(gcloud config get-value project)
```

### Edit Files

As of RBAC Constraints on GKE, it's necessary to edit one file. 

[permissions.yml](../services/traefik/01_permissions.yml)

On line 12
```
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: <yourgcpaccountemail.com>
```

please enter your valid GCP account email.

### Create Cluster
```
terraform init
terraform apply
```

### Setup Kubectl
```
gcloud container clusters get-credentials $(terraform output cluster_name) --zone $(terraform output cluster_zone)
```

### Spawn Traefik as Ingress Controller
```
kubectl apply -f services/traefik
```

### Spawn Demo Services
```
kubectl apply -f services/whoami
kubectl apply -f services/nginx
```