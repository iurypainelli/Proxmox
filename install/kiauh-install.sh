#!/usr/bin/env bash

# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt-get install -y curl
$STD apt-get install -y sudo
$STD apt-get install -y mc
$STD apt-get install -y git
msg_ok "Installed Dependencies"

msg_info "Setting up kiauh"
$STD mkdir -p /opt/kiauh
$STD git clone --depth 1 https://github.com/dw-0/kiauh.git /opt/kiauh
$STD useradd -d /opt/kiauh kiauh
$STD chown -R kiauh:kiauh /opt/kiauh
# $STD su kiauh -s /bin/sh -c "./opt/kiauh/kiauh.sh"
msg_ok "Set up kiauh"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"