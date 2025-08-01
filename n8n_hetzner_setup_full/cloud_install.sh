#cloud-config
package_update: true
package_upgrade: true

runcmd:
  - mkdir -p /root/n8n
  - git clone https://github.com/habuba/n8n-setup.git /root/n8n-setup || true
  - cd /root/n8n-setup/n8n_hetzner_setup_full
  - chmod +x install_with_nip.sh
  - chmod +x scripts/*.sh
  - ./install_with_nip.sh | tee /root/n8n-install.log
