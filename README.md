# Home Assistant setup and backup utils

version 0.0.1

## How to use

This is for Raspberry Pi 3. You may need to modify the image name in Makefile and scripts to make it work on other platforms.

Clone this repo or get the zip. 

### Pre-requisites

Create a dir for your installation e.g. `/opt/homeassistant`.

Your configuration files will be created to `config` sub dir with the first time run.

Init git repo in the installation dir and set a remote repository for backups (out of scope of this document).

Docker must be installed and configured properly.

Copy the files in this cloned directory to your installation dir. Do not copy .git subdir.

### Initial setup

#### Run Home Assistant in a container for first time:

    make run

#### Stop the container

    make stop

#### Start the stopped container

    make start

#### Restart the container

    make restart

#### Check running status

    make status
    
### Update

* Modify your Home Assistant API key (YOUR_HA_API_TOKEN) in `secrets`.
* Modify your Home Assistant instance address (IP:PORT) in `secrets`. 'localhost:8123' might work out of the box.
* Add `secrets` in .gitignore if you don't want to backup your API settings

#### Upgrade Home Assistant with the newest image:

    make upgrade

or
    
    bash run.sh update

#### Clean unused images

    make clean

### Other actions

#### Delete container

    make rm

#### Take a backup

    make backup

or

    bash backup.sh

