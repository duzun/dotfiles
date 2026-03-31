#!/bin/bash


tunel_udp_over_ssh() {
    # Usage: tunel_udp_over_ssh <remote_host> <udp_port> <tcp_port>

    # E.g. uzer@myserver.com
    local remote=$1
    # E.g. 51820
    local udp_port=$2
    # Intermediate port for TCP, default 11111
    local tcp_port=${3:-11111}
    # Local bind IP for both TCP and UDP, default 127.0.0.1
    local local_bind_ip=${4:-127.0.0.1}

    ssh -L "${tcp_port}:${local_bind_ip}:${tcp_port}" "${remote}" \
        "socat TCP4-LISTEN:${tcp_port},fork UDP4:${local_bind_ip}:${udp_port}" &
    socat "UDP4-LISTEN:${udp_port},fork" "TCP4:${local_bind_ip}:${tcp_port}"
}
