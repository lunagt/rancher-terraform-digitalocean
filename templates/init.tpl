#cloud-config
users:
  - name: luna
    groups: sudo
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    shell: /bin/bash
    home: /home/luna
    lock_passwd: true
    ssh-authorized-keys:
      - ${userdata_sshkey}

disable_root: true

apt_update: true
package_update: true
packages:
 - iptables-persistent

runcmd:
 - iptables -A INPUT -i lo -j ACCEPT
 - iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
 - iptables -A INPUT -p tcp --dport ssh -j ACCEPT
 - iptables -A INPUT -p tcp --dport 80 -j ACCEPT
 - iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
 - iptables -I INPUT 1 -i eth0 -p tcp --dport 8080 -j ACCEPT
 - iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
 - iptables -A INPUT -j DROP
 - iptables -A OUTPUT -j ACCEPT
 - sudo netfilter-persistent save
 - sudo netfilter-persistent reload
 - apt-get update --fix-missing
 - docker run -d -v /var/lib/mysql:/var/lib/mysql --restart=unless-stopped -p 8080:8080 rancher/server:stable
