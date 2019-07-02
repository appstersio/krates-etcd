#!/usr/bin/env bats

load "/usr/bin/common.bash"

@test "etcd/write single-line value performs as expected" {
  run etcdctl set /staticpagesio/haproxy/lb/services/service-b/ip_addr "127.0.0.1"
  run etcdctl get /staticpagesio/haproxy/lb/services/service-b/ip_addr
  [ "$status" -eq 0 ]
  [ "$output" = "127.0.0.1" ]
}