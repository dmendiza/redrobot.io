title:   Installing Fedora Server 30 (64-bit) on a Raspberry Pi
date:    2019-05-09
tags:    linux
slug:    fedora-30-on-raspberry-pi
authors: Douglas Mendizábal

# Installing Fedora Server 30 (64-bit) on a Raspberry Pi

Raspbian is the official Operating System for the Raspberry Pi and while
it's a great OS, I was not quite happy with it.  For starters I've been
using Fedora for years, so I often found myself typing the wrong commands
or package names.

Newer Raspberry Pis use ARMv8 processors which have a 64-bit architecture,
but Raspbian is a 32-bit OS.  So when I saw that Fedora was building a
64-bit ARM distribution, I knew I had to make the switch so I could make
use of all my Raspberry bits.

(Full Disclosure:  I am currently employed by Red Hat, but I've been using
Fedora on the desktop and Raspberries long before that.)

I mainly use my Raspberry Pi as a headless web server which is why I choose the
Server edition of Fedora.  In this guide, I'm going to document how to install
Fedora ARM Server aarch64 on a Raspberry Pi 3B+ using a Linux system to
prepare the SD Card.

First things first, you're going to need to download the Fedora raw image
along with its CHECKSUM file.  We're going to download the `aarch64` build,
which is the 64-bit edition.  If you're looking for the 32-bit version for
older ARMv7 Raspberries, you'll want to download the `armhfp` version.

Both the `aarch64` image and CHECKSUM file can be downloaded here:

https://download.fedoraproject.org/pub/fedora/linux/releases/30/Server/aarch64/images

It is a good idea to always [verify your image downloads](https://getfedora.org/en/verify).
So let's verify the image we just downloaded:

* First, import Fedora's GPG keys:

      curl https://getfedora.org/static/fedora.gpg | gpg --import

* Now, verify that the CHECKSUM file is valid

      gpg --verify-files Fedora-Server-30-1.2-aarch64-CHECKSUM

  We're mainly looking for this line in the output:

      gpg: Good signature from "Fedora (30) <fedora-30-primary@fedoraproject.org>" ...

* Now that we know that the CHECKSUM file is valid, lets use it to validate
  the image file:

      sha256sum -c Fedora-Server-30-1.2-aarch64-CHECKSUM

  You should see this line in the output:

      Fedora-Server-30-1.2.aarch64.raw.xz: OK

* At this point we know that we have a valid image file.  If one of the
  validation steps failed for you, try downloading the files again.  The
  image file is compressed, so we have to decompress before we can burn it
  onto an SD Card:

      unxz Fedora-Server-30-1.2.aarch64.raw.xz

* Insert your SD Card now, and check to see the device path.  Be careful here,
  because typing the wrong path may end up erasing something you care about!
  It's usually a good idea to execute `lsblk` before and after inserting the
  SD Card just to make sure you know exactly which device corresponds to your
  SD Card.  Typically the device will be /dev/mmcblkX where X is a number.
  For example, in my workstation the SD Card is `/dev/mmcblk0`.  If there
  are any MOUNTPOINTS listed under that device, you will need to unmount them
  before we can burn the image.

      lsblk
      sudo umount /dev/mmcblk0p1
      sudo umount /dev/mmcblk0p3

  Now we're ready to burn the image!

      dd bs=4m if=Fedora-Server-30-1.2.aarch64.raw of=/dev/mmcblk0 status=progress

* There's just one more thing left before we can boot up the Raspberry, and
  that is to resize the system partition.  The default partition in the image
  is only about 6GB, so if your SD card is bigger (and it should be) you will
  have a lot of unused space that we'll need to reclaim.

  The easiest way to do that is to resize it using `gparted`:

  <gparted.png here>

  Click on the 3rd partition (/dev/mmcblk0p3, fedora), choose
  Partition -> Resize/Move from the menu, and slide the partition so that
  it takes up all of the free space, and then click the "Apply All Operations"
  checkmark.

  <gparted_XX.png here>

At this point we're ready to boot up the Raspberry Pi, but there is still one
more step left to fully expand the partition.  Go ahead and boot the Raspberry
Pi and go through the Fedora setup process.  You'll be adding your user,
setting up your Language and Time Zone, etc.

Once your Raspberry Pi boots, run these commands to expand the LVM volume and
the file system to fill the new partition size:

    sudo lvextend -l100%PVS /dev/fedora/root
    sudo xfs_growfs /

We're almost done!  Now comes the hardest part out of the whole process: Naming
your new server.

    sudo hostnamectl set-hostname bowser

And that's it.  Now your Raspberry Pi is ready for you to configure it and
start serving your website, private git repositorier, IRC bouncer, or anything
else.
