# Hamberry Pi

A Remote Linux Desktop for running Amateur Radio digital modes software on Raspberry Pi.

## Running

#### Prerequisites:
* [Raspberry Pi](https://www.raspberrypi.org/products/) (tested on Pi 3) running a Linux distribution of your choice is required.
* [Docker](https://www.docker.com) - The desktop runs in a container. See the instructions [here](https://docs.docker.com/install/linux/docker-ce/debian/) to get Docker installed and running under Raspbian. If your Pi is not running Raspbian, consult your distro's documentation.
* [docker-compose](https://docs.docker.com/compose/install/) - Hamberry uses Compose to build and run the desktop.

#### Quick-Start:
1. Install the prerequisites.
2. Edit `Dockerfile` and `docker-compose.yml` to make any necessary changes or include additional software.
3. Choose a username: `export HAMBERRY_USER=mycall`
4. Choose a password: `export HAMBERRY_PASSWORD=hunter2`
5. Run Compose: `docker-compose up -d`

#### Logging In:
The Compose build may take some time to complete. To access the desktop, point your browser to `https://<your-raspberry-pi-ip>:8443`, log in with your chosen username and password, and enjoy!

#### Included Software:
* Direwolf
* Fldigi
* GPredict
* QSSTV
* TrustedQSL
* JTDX
* XASTIR
* xlog

