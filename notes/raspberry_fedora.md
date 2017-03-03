date: 2017-02-23
updated: 2017-02-25

* Fedora 25 - Server image
  https://fedoraproject.org/wiki/Raspberry_Pi
* Resize partition
  https://www.raspberrypi.org/forums/viewtopic.php?f=51&t=45265
* Manual update
  sudo dnf upgrade
  sudo reboot
* ansible-playbook -i hosts -k -K bootstrap_user.yaml
* ansible-playbook -i hosts lxc_host.yaml
* ansible-playbook -i hosts docker_host.yaml
* curl -sSL https://dl.fedoraproject.org/pub/fedora/linux/releases/25/Docker/armhfp/images/Fedora-Docker-Base-25-1.3.armhfp.tar.xz | unxz | sudo docker load
* ansible-playbook -i hosts git_repo.yaml
* move source to the new git repo in the pi and manually build docker image
  sudo docker build -t redrobot src/
* run the container manually because the start_blog_container.yaml playbook requires python 2
  sudo docker run -d -e DJANGO_SECRET_KEY=$(cat django-secret-key) -p 8000:8000 redrobot

* ansible-playbook -i hosts nginx.yaml
