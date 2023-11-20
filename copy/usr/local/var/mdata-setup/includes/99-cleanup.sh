#!/usr/bin/bash

mdata-delete mail_smarthost || true
mdata-delete mail_auth_user || true
mdata-delete mail_auth_pass || true
mdata-delete mail_adminaddr || true
mdata-delete admin_authorized_keys || true
mdata-delete root_authorized_keys || true

# apt-get -y purge git make gcc g++ build-essential
# apt-get -y autoremove
# rm -rf zulip-server-* || true
# rm -rf /usr/local/var/tmp/* || true
