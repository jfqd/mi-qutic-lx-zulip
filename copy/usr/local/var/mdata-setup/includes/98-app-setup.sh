#!/usr/bin/bash
cd /root

export TMPDIR=/var/tmp

EMAIL=$(/native/usr/sbin/mdata-get zulip_admin_email)
HOST=$(/native/usr/sbin/mdata-get zulip_external_host)

# get it installed
for ((i=1;i<=6;i++)); do
  echo "* install zulip, running loop: ${i}"
  /root/zulip-server-*/scripts/setup/install --self-signed-cert --email="${EMAIL}" --hostname="${HOST}"
  if [ $? -eq 0 ]; then
    break
  fi
done

echo "* fix chrony service"
sed -i \
    -e "s|PIDFile=/run/chrony/chronyd.pid|#PIDFile=/run/chrony/chronyd.pid|" \
    /etc/systemd/system/chrony.service
systemctl daemon-reload
systemctl start chrony

echo "* setup mailer"
# https://zulip.readthedocs.io/en/stable/production/email.html
if /native/usr/sbin/mdata-get mail_smarthost 1>/dev/null 2>&1; then
  echo "* Setup mail"
  MAIL_UID=$(/native/usr/sbin/mdata-get mail_auth_user)
  MAIL_PWD=$(/native/usr/sbin/mdata-get mail_auth_pass)
  MAIL_HOST=$(/native/usr/sbin/mdata-get mail_smarthost)
  sed -i \
      -e "s|# EMAIL_HOST = \"smtp.example.com\"|EMAIL_HOST = \"${MAIL_HOST}\"|" \
      -e "s|# EMAIL_HOST_USER = \"\"|EMAIL_HOST_USER = \"${MAIL_UID}\"|" \
      -e "s|# EMAIL_USE_TLS = True|EMAIL_USE_TLS = True|" \
      -e "s|# EMAIL_PORT = 587|EMAIL_PORT = 587|" \
      /etc/zulip/settings.py
  echo "email_password = \"${MAIL_PWD}\"" >> /etc/zulip/zulip-secrets.conf
fi
chmod 0640 /etc/zulip/settings.py


# [loadbalancer]
# # Use the IP addresses you determined above, separated by commas.
# ips = 192.168.0.100
# /home/zulip/deployments/current/scripts/zulip-puppet-apply
# /home/zulip/deployments/current/scripts/restart-server