cd /root

# EMAIL=$(/native/usr/sbin/mdata-get zulip_admin_email)
# HOST=$(/native/usr/sbin/mdata-get zulip_external_host)

# ./zulip-server-*/scripts/setup/install --self-signed-cert --email="${EMAIL}" --hostname="${HOST}"

# https://zulip.readthedocs.io/en/stable/production/email.html
# /etc/zulip/settings.py
# /etc/zulip/zulip-secrets.conf

# [loadbalancer]
# # Use the IP addresses you determined above, separated by commas.
# ips = 192.168.0.100
# /home/zulip/deployments/current/scripts/zulip-puppet-apply
# /home/zulip/deployments/current/scripts/restart-server