date: 2017-02-23

* Workstation image
  https://fedoraproject.org/wiki/Raspberry_Pi
* Resize partition
  https://www.raspberrypi.org/forums/viewtopic.php?f=51&t=45265
* Manual update
  sudo dnf upgrade
  sudo reboot
* ansible-playbook -i hosts -k -K bootstrap_user.yaml
