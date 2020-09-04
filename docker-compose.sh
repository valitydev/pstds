#!/bin/bash
cat <<EOF
version: '2.1'

services:

  ${SERVICE_NAME}:
    image: ${BUILD_IMAGE}
    volumes:
      - .:$PWD
      - $HOME/.cache:/home/$UNAME/.cache
      - $HOME/.ssh:/home/$UNAME/.ssh:ro
    working_dir: $PWD
    command: /sbin/init
    depends_on:
      riakdb:
        condition: service_healthy

  riakdb:
    image: dr2.rbkmoney.com/rbkmoney/riak-base:38fbd6239f7d1f7cac45912a7031aea8db010b0c
    environment:
      - CLUSTER_NAME=riakkv
    labels:
      - "com.basho.riak.cluster.name=riakkv"
    volumes:
      - ./test/riak/user.conf:/etc/riak/user.conf:ro
    healthcheck:
      test: "riak-admin test"
      interval: 5s
      timeout: 5s
      retries: 20
  member:
    image: dr2.rbkmoney.com/rbkmoney/riak-base:38fbd6239f7d1f7cac45912a7031aea8db010b0c
    labels:
      - "com.basho.riak.cluster.name=riakkv"
    links:
      - riakdb
    depends_on:
      - riakdb
    environment:
      - CLUSTER_NAME=riakkv
      - COORDINATOR_NODE=riakdb
    volumes:
      - ./test/riak/user.conf:/etc/riak/user.conf:ro

volumes:
  schemas:
    external: false

EOF

