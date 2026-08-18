#!/bin/bash

# This script is used to gather network information on a Linux system.

IFACE=$(ip route show default 2>/dev/null | awk '/default/ {print $5}' | head -n1)
if [ -z "$IFACE" ]; then
  echo "Not connected"
else
  CONN_NAME=$(nmcli -t -f NAME,DEVICE connection show --active 2>/dev/null | grep ":$IFACE" | cut -d: -f1)
  [ -z "$CONN_NAME" ] && CONN_NAME="$IFACE"
  # Detect if vpn is activated
  VPN_NM=$(nmcli -t -f TYPE connection show --active 2>/dev/null | grep -E -i 'tun[0-9]|tap[0-9]|wg[0-9]|wireguard|ppp[0-9]|openvpn|vpn' | head -n1)
  if [ -n "$VPN_NM" ]; then
    echo "Connected: $CONN_NAME VPN: Active"
  else
    echo "Connected: $CONN_NAME"
    # echo "VPN: Inactive"
  fi
fi
