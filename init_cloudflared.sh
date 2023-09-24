#!/sbin/openrc-run
  
name=$(basename $(readlink -f $0))
cfgfile="/etc/$RC_SVCNAME/$RC_SVCNAME.conf"
command="/usr/bin/cloudflared"
command_args="--pidfile /var/run/$name.pid --autoupdate-freq 24h0m0s --config /etc/cloudflared/config.yml tunnel run"
command_user="root"
pidfile="/var/run/$name.pid"
stdout_log="/var/log/$name.log"
stderr_log="/var/log/$name.err"
command_background="yes"
