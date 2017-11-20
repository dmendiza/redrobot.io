date: 2017-02-23
updated: 2017-11-19

* Fedora 27 - Server image
  https://fedoraproject.org/wiki/Raspberry_Pi

    unxz Fedora-Minimal-armhfp-27-1.6-sda.raw.xz

* Resize partition
  https://www.raspberrypi.org/forums/viewtopic.php?f=51&t=45265

    mkpart primary ext4 XXX,XXX,XXX 122223,110,1
    set 4 lba off

    sudo resize2fs /dev/mmcblk0p4

* ansible-playbook -i hosts -k -K bootstrap_host.yaml
  FIXME: ansible can't set the hostname for some reason, so we can't use
  the bootstrap_host.yaml playbook.  For now set it manually.

    sudo hostnamectl set-hostname haineko

* ansible-playbook -i hosts -k -K bootstrap_user.yaml

TODO:

* ansible-playbook -i hosts lxc_host.yaml
* ansible-playbook -i hosts docker_host.yaml
* curl -sSL https://dl.fedoraproject.org/pub/fedora/linux/releases/25/Docker/armhfp/images/Fedora-Docker-Base-25-1.3.armhfp.tar.xz | unxz | sudo docker load
* ansible-playbook -i hosts git_repo.yaml
* move source to the new git repo in the pi and manually build docker image
  sudo docker build -t redrobot src/
* run the container manually because the start_blog_container.yaml playbook requires python 2
  sudo docker run -d -e DJANGO_SECRET_KEY=$(cat django-secret-key) -p 8000:8000 redrobot

* ansible-playbook -i hosts nginx.yaml
