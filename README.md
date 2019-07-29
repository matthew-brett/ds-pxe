# PXE server to install Lubuntu on many laptops

## What it does

I use this system to install identical fresh copies of
[Lubuntu](https://lubuntu.me/) on laptops for my students.

It is a way to rescue some old laptops that my department does not want any
more. This way my students can take away a laptop for the whole university
year.  Although the laptop is too slow to run Windows, the Lubuntu install
makes it usable for the work they need to do for my data science classes.

The install system runs on my office desktop. Luckily that has two Ethernet
ports, so it is easy to run the install system services such as DHCP on
a private internal network.

I plug the laptops into Ethernet ports on a switch on my desk, that is
connected to my desktop, and boot the laptop from the LAN.  After about an
hour, the laptop has a complete custom Lubuntu install, with all updates, and
a fresh copy of RStudio, with the libraries needed for R Notebooks.  In due
course I'll add more installs, but this is now just a question of extending
a bash script `post_install.sh`, in this framework.

My desktop acts as a proxy server for the installs, so it caches Ubuntu
packages as the installer downloads them from the Ubuntu servers.  This means
that the external network traffic for a second install is much less.

As you'll see, the whole system involves running DHCP / PXE / TFTP and HTTP
services on the desktop.

In fact, my desktop is a Mac, and these instructions reflect that, somewhat,
but of course you can do the same from a Linux box.

## Links

* [Customizing Ubuntu install
  CD](https://help.ubuntu.com/community/InstallCDCustomization)
* [Automating installs with preseed
  files](https://help.ubuntu.com/lts/installation-guide/amd64/apb.html)
* [An example preseed
  file](https://github.com/core-process/linux-unattended-installation/blob/master/ubuntu/18.04/custom/preseed.cfg)
* [Another preseed
  example](https://f-o.org.uk/2017/automating-debian-installation-using-preseeding.html)

There are other links in the `lubuntu-install/preseed.cfg` file.

## Setup

For macOS, specifically, see [Setup for PXE boot server on
Mac](http://hints.macworld.com/article.php?story=20130625164022823).

I believe you will want [dnsmasq and
friends](https://blogging.dragon.org.uk/howto-setup-a-pxe-server-with-dnsmasq/)
for Linux, but the last time I did that install was [a long time
ago](https://web.archive.org/web/20050404192431/http://dynevor.hopto.org:80/linuxiste/10p1/x40_mandrake_10p1.html#tocref10).

The steps below follow the macOS / PXE setup link above, but where they are
specific to macOS, their Linux equivalents should be obvious.

First check what IP your HTTP server will be running on.  In my case, that's
`192.168.2.1`.  Change these files accordingly:

* `tftpboot/pxelinux.cfg/default`
* `conf/bootpd.plist` (macOS specific)

Fetch all the relevant files for the installer with:

```
make all
```

macOS specific: link web directory with install files and Tftp directory for net boot with:

```
make weblinks
```

Start Tftp server on macOS with:

```
sudo launchctl load -w /System/Library/LaunchDaemons/tftp.plist
```

Test Tftp server with:

```
tftp localhost
tftp> get lpxelinux.0
Received 92766 bytes in 1.7 seconds
tftp> q
```

Set up macOS DHCP + PXE boot service by editing `conf/bootpd.plist` to match
your system, and then:

```
sudo cp confs/bootpd.plist /etc/bootpd.plist
sudo launchctl load -w /System/Library/LaunchDaemons/bootps.plist
```

I'm using the web server as a proxy server, to reduce external traffic from the
Ubuntu installs.  The proxy server should cache all the `.deb` packages,
greatly reducing network bandwidth for the second and subsequent installs. See
`conf/httpd.conf` for Apache parameters.  Append to `/etc/apache2/httpd.conf`
and `sudo apachectl restart`.

Check with:

```
curl -LO localhost/lubuntu-install/preseed.cfg
```

Consider reviewing `/var/log/apache2/error_log` to check that the proxy server
is caching correctly.

Last, you'll need to set the hash for your default user's password in the
`lubuntu-install/preseed.cfg` file.

OK - maybe all done - try to boot a machine from the network, to begin an
install.
