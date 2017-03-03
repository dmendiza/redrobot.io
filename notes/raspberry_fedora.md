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

* sudo docker run -d -e DJANGO_SECRET_KEY=$(cat django-secret-key) -p 8000:8000 redrobot
