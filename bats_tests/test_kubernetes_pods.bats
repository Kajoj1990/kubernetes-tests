#!/usr/bin/env bats

set -o pipefail

load helpers

# Kubernetes Pods

@test "kube-apiserver" {
  kubectl get pod kube-apiserver-master-$STACK_ID.$ENVIRONMENT.kube --namespace=kube-system | grep Running
}

@test "kube-controller-manager" {
  kubectl get pod kube-controller-manager-master-$STACK_ID.$ENVIRONMENT.kube --namespace=kube-system | grep Running
}

@test "kube-podmaster" {
  kubectl get pod kube-podmaster-master-$STACK_ID.$ENVIRONMENT.kube --namespace=kube-system | grep Running
}

@test "kube-proxy master" {
  kubectl get pod kube-proxy-master-$STACK_ID.$ENVIRONMENT.kube --namespace=kube-system | grep Running
}

@test "kube-scheduler" {
  kubectl get pod kube-scheduler-master-$STACK_ID.$ENVIRONMENT.kube --namespace=kube-system | grep Running
}

@test "fabric8" {
  kubectl get pods --namespace=default --no-headers | grep fabric8 | grep Running
}

@test "kube-ui-v1" {
  kubectl get pods --namespace=kube-system --no-headers | grep kube-ui-v1 | grep Running
}
