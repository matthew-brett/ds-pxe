# PXE server to install Lubuntu on many laptops

I'm using a Mac Pro as a DHCP / PXE / TFTP / HTTP server, but of course you can
do the same from a Linux box.

# Links

* [Customizing Ubuntu install
  CD](https://help.ubuntu.com/community/InstallCDCustomization)
* [Automating installs with preseed
  files](https://help.ubuntu.com/lts/installation-guide/amd64/apb.html)
* [An example preseed
  file](https://github.com/core-process/linux-unattended-installation/blob/master/ubuntu/18.04/custom/preseed.cfg)
* [Another preseed
  example](https://f-o.org.uk/2017/automating-debian-installation-using-preseeding.html)

There are other links in the `lubuntu-install/preseed.cfg` file.

For Mac, specifically, see [Setup for PXE boot server on
Mac](http://hints.macworld.com/article.php?story=20130625164022823).

## Setup

This largely follows the link above.

First check what IP your HTTP server will be running on.  In my case, that's
`192.168.2.1`.  Change these files accordingly:

* `conf/bootpd.plist`
* `tftpboot/pxelinux.cfg/default`

Fetch all the relevant files for the installer with:

```
make all
```

Link web directory with install files and tftp directory for net boot with:

```
make weblinks
```

Start Tftp server with:

```
sudo launchctl load -w /System/Library/LaunchDaemons/tftp.plist
```

Test Tftp server with:

```
tftp localhost
tftp> get lpxelinux.0
Received 42226 bytes in 0.1 seconds
tftp> q
```

Set up DHCP + PXE boot service by editing `conf/bootpd.plist` to match your system, and then:

```
sudo cp confs/bootpd.plist /etc/bootpd.plist
sudo launchctl load -w /System/Library/LaunchDaemons/bootps.plist
```

I'm using the web server as a proxy server, to reduce external traffic from the Ubuntu installs.  The proxy server should cache all the `.deb` packages, greatly reducing network bandwidth for the second and subsequent installs. See `conf/httpd.conf` for Apache parameters.  Append to `/etc/apache2/httpd.conf` and `sudo apachectl restart`.

Check with:

```
curl -LO localhost/lubuntu-install/preseed.cfg
```

Consider reviewing `/var/log/apache2/error_log` to check that the proxy server is caching correctly.

Last, you'll need to set the hash for your default user's password in the `lubuntu-install/preseed.cfg` file.

OK - maybe all done - try to boot a machine from the network, to begin an install.
