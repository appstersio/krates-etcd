#!/usr/bin/env bats

load "/usr/bin/common.bash"

@test "etcd cluster is online" {
  run etcdctl cluster-health

  [ "$status" -eq 0 ]
  assert_output_contains "result from http://etcd:2379"
}

@test "etcd cluster is healthy" {
  run etcdctl cluster-health

  [ "$status" -eq 0 ]
  assert_output_contains "cluster is healthy"
}

@test "etcd cluster has exactly one member" {
  run etcdctl cluster-health

  [ "$status" -eq 0 ]
  [ $(expr "${lines[0]}" : "member .* is healthy:.*") -ne 0 ]
  [ $(expr "${lines[1]}" : "cluster is healthy") -ne 0 ]
}