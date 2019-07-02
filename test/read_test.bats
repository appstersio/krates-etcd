#!/usr/bin/env bats

load "/usr/bin/common.bash"

setup() {
  etcdctl set /staticpagesio/haproxy/lb/services/service-b/virtual_hosts *.foo.com
  etcdctl set /staticpagesio/haproxy/lb/services/service-b/custom_settings "
    acl wildcard hdr_reg(host) ^\w*\.foo.com\w*
    redirect code 301 location foo.com%[capture.req.uri] if wildcard
  "
}

teardown() {
  etcdctl rm /staticpagesio/haproxy/lb/services/service-b/virtual_hosts
  etcdctl rm /staticpagesio/haproxy/lb/services/service-b/custom_settings
}

@test "etcd/read single-line value performs as expected" {
  run etcdctl get /staticpagesio/haproxy/lb/services/service-b/virtual_hosts

  [ "$status" -eq 0 ]
  [ "$output" = "*.foo.com" ]
}

@test "etcd/read multi-line value performs as expected" {
  run etcdctl get /staticpagesio/haproxy/lb/services/service-b/custom_settings

  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "    acl wildcard hdr_reg(host) ^\w*\.foo.com\w*" ]
  [ "${lines[1]}" = "    redirect code 301 location foo.com%[capture.req.uri] if wildcard" ]
}