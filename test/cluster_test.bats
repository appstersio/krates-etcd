#!/usr/bin/env bats

load "/usr/bin/common.bash"

@test "etcd endpoint is online" {
  run etcdctl endpoint health

  [ "$status" -eq 0 ]
  assert_output_contains "http://etcd:2379 is healthy:"
}

@test "etcd endpoint has expected version" {
  run etcdctl endpoint status

  [ "$status" -eq 0 ]
  [ $(expr "${lines[0]}" : "http://etcd:2379, .*, ${ETCD_VERSION}") -ne 0 ]
}