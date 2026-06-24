# debian-LUX

Use the Debian (ncurses) installer to install the base system.

Recommended settings are:

    Language: English
    
    Country: United Kingdom
    
    Keymap: British English
    
    Hostname: debian
    
    Domain name: N/A
    
    Root password: ***
    
    Full name: $USER
    
    User name: $USER
    
    User password: ***
    
    Partitioning method: Guided - use entire disk
    
    Select disk: Default disk
    
    Partitioning scheme: All files in one partition
    
    Scan extra installation media?: No
    
    Debian archive mirror country: United Kingdom
    
    Debian archive mirror: deb.debian.org
    
    HTTP proxy information: N/A
    
    Participate in the package usage survey?: No
    
    Choose software to install: standard system utilities
    
Then log into the newly configured system.

Elevate privileges with 'su -' and run the following command:
    
    apt install -y sudo git;usermod -aG sudo gsb;exit
    
Log out and back in (or reboot) then run the following command:

    git clone https://github.com/georgesb1998/debian-LUX.git;sudo bash ~/debian-LUX/install.sh
    
Then reboot the system to log into KDE Plasma.
