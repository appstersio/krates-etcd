#!/usr/bin/env bats

load "/usr/bin/common.bash"

setup() {
  etcdctl put /staticpagesio/haproxy/lb/services/service-b/virtual_hosts *.foo.com
  etcdctl put /staticpagesio/haproxy/lb/services/service-b/custom_settings "
    acl wildcard hdr_reg(host) ^\w*\.foo.com\w*
    redirect code 301 location foo.com%[capture.req.uri] if wildcard
  "
}

teardown() {
  etcdctl del /staticpagesio/haproxy/lb/services/service-b/virtual_hosts
  etcdctl del /staticpagesio/haproxy/lb/services/service-b/custom_settings
}

@test "etcd/read single-line value performs as expected" {
  run etcdctl get /staticpagesio/haproxy/lb/services/service-b/virtual_hosts --print-value-only

  [ "$status" -eq 0 ]
  [ "$output" = "*.foo.com" ]
}

@test "etcd/read multi-line value performs as expected" {
  run etcdctl get /staticpagesio/haproxy/lb/services/service-b/custom_settings --print-value-only

  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "    acl wildcard hdr_reg(host) ^\w*\.foo.com\w*" ]
  [ "${lines[1]}" = "    redirect code 301 location foo.com%[capture.req.uri] if wildcard" ]
}