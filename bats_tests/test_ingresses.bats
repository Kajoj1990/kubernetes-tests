#!/usr/bin/env bats

set -o pipefail

load helpers

# Ingress

@test "consul ingress" {
  kubectl get ing consul --namespace=kube-system --no-headers
}

@test "vault ingress" {
  kubectl get ing vault --namespace=kube-system --no-headers
}

@test "grafana ingress" {
  kubectl get ing grafana --namespace=default --no-headers
}

@test "ingress without host defined does not generate" {
  assets_folder="/tmp/kubernetes-tests/test_assets"
  existingIngress=kubectl get ing --namespace=kube-system ingress-host-test --no-headers
  if [[ "$existingIngress" != "" ]]; then
    kubectl delete -f $assets_folder/ingress.hashost.yaml
  fi
  kubectl create -f $assets_folder/ingress.hashost.yaml
  sleep 10
  for pod in $(kubectl get pods --namespace=kube-system | grep -oEi "nginx-ingress-[0-9a-z]+"); do
    kubectl exec -it --namespace=kube-system $pod -- cat /etc/nginx/nginx.conf>hosts.txt
    grep "ingress-host-test" hosts.txt>hosts.txt
    line_count=wc -l hosts.txt
    [ "$line_count" -gt 0 ]
  done
  kubectl delete -f $assets_folder/ingress.hashost.yaml
  kubectl create -f $assets_folder/ingress.nohost.yaml
  sleep 10
  for pod in $(kubectl get pods --namespace=kube-system | grep -oEi "nginx-ingress-[0-9a-z]+"); do
    kubectl exec -it --namespace=kube-system $pod -- cat /etc/nginx/nginx.conf>hosts.txt
    grep "ingress-host-test" hosts.txt>hosts.txt
    line_count=wc -l hosts.txt
    [ "$line_count" -eq 0 ]
  done
  kubectl delete -f $assets_folder/ingress.nohost.yaml
}

#@test "es ingress" {
#  kubectl get ing es-ingress --namespace=default --no-headers
#}
