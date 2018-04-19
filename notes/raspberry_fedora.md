date: 2017-02-23
updated: 2018-04-05

* Fedora 28 Beta - Server image

    gpg --verify-files Fedora-Server-28_Beta-1.3-armhfp-CHECKSUM
    cat Fedora-Server-28_Beta-1.3-armhfp-CHECKSUM
    shasum -a 256 Fedora-Server-armhfp-28_Beta-1.3-sda.raw.xz
    unxz Fedora-Server-armhfp-28_Beta-1.3-sda.raw.xz

* Prepare SD Card

    diskutil list
    diskutil unmoutDisk /dev/disk2
    dd bs=4m if=Fedora-Xfce-armhfp-28_Beta-1.3-sda.raw of=/dev/disk2

* Resize partition
  https://www.raspberrypi.org/forums/viewtopic.php?f=51&t=45265

    sudo parted /dev/mmcblk0
    unit chs
    print
    rm 4
    mkpart primary xfs XXX,XXX,XXX 122223,110,1
    set 4 lba off

    sudo xfs_growfs /

* ansible-playbook -i hosts -k -K bootstrap_host.yaml
  FIXME: ansible can't set the hostname for some reason, so we can't use
  the bootstrap_host.yaml playbook.  For now set it manually.

    sudo hostnamectl set-hostname haineko

* ansible-playbook -i hosts -k -K bootstrap_user.yaml
* ansible-playbook -i hosts update.yaml
* ansible-playbook -i hosts common.yaml

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
