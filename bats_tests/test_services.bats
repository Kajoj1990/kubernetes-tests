#!/usr/bin/env bats

set -o pipefail

load helpers

# Services

@test "kubernetes service" {
  kubectl get svc kubernetes --namespace=default --no-headers
}

@test "bitesize-registry service" {
  kubectl get svc bitesize-registry --namespace=default --no-headers
}

@test "fabric8 service" {
  kubectl get svc fabric8 --namespace=default --no-headers
}

@test "kube-dns service" {
  kubectl get svc kube-dns --namespace=kube-system --no-headers
}

@test "kube-ui service" {
  kubectl get svc kube-ui --namespace=kube-system --no-headers
}

# @test "elasticsearch service" {
#   kubectl get svc elasticsearch --namespace=default --no-headers
# }
#
# @test "elasticsearch-discovery service" {
#   kubectl get svc elasticsearch-discovery --namespace=default --no-headers
# }

@test "monitoring-heapster service" {
  kubectl get svc monitoring-heapster --namespace=kube-system --no-headers
}

@test "grafana service" {
  kubectl get svc grafana --namespace=default --no-headers
}

@test "keycloak service" {
  if [ $BRAIN != "true" ]; then
    skip "Not brain"
  fi

  kubectl get svc keycloak --namespace=keycloak --no-headers
}
