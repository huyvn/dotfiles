# Setup root-less container with podman for unifi-controller

## Setup podman

### Run as an admin user

```bash
# install podman and podman-compose
sudo pacman -S podman podman-compose

# setup a service user to run rootless container
export SVC_USER="podman"
sudo useradd -r -m -d "/home/${SVC_USER}" -s /bin/false "${SVC_USER}"  # change to /bin/bash if you want a shell
sudo loginctl enable-linger "${SVC_USER}"

# prepare for rootless container
sudo touch /etc/subuid /etc/subgid
sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 "${SVC_USER}"
sudo podman system migrate

# switch to the service user 
sudo -H -u "${SVC_USER}" bash -c 'cd; bash'
```

### Run as the service user

```bash
# make sure shell env is correct
cat << EOF > ~/.bashrc
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
EOF

cat << EOF > ~/.profile
[[ -f ~/.bashrc ]] && . ~/.bashrc
EOF

source ~/.profile

# check podman is able to run as rootless user
podman run --rm docker.io/library/hello-world

# enable and check podman-compose can run
systemctl --user enable --now podman.service
systemctl --user status podman.service
curl -H "Content-Type: application/json" --unix-socket /run/user/1001/podman/podman.sock http://localhost/_ping  # print OK
```

## First time setup the container

Run as the service user above

```bash
# make a folder to hold the data inside container
mkdir -p ~/unifi-controller/data

# copy the docker-compose.yml file
vi ~/unifi-controller/docker-compose.yml

# standup the container
podman-compose up
```

The container should be up when you see the log below

```
unifi-controller    | [services.d] starting services
unifi-controller    | [services.d] done.
```

Use a browser to open `https://localhost:8443` to see the Unifi Controller UI.

Detach from the running container without stopping it by pressing `CTRL+p` followed by `CTRL+q`

## Make container run on boot

Run as service user 

```bash
# This should work after you setup XDG_RUNTIME_DIR as above
systemctl --user

# generate the SystemD unit file
mkdir -p ~/.config/systemd/user/
podman generate systemd --restart-policy always --name unifi-controller > ~/.config/systemd/user/container-unifi-controller.service

# reload new config
systemctl --user daemon-reload

# start service on boot
systemctl --user enable --now container-unifi-controller.service
```

Done!

## Update container image

Run as service user

```bash
# Pull latest image
cd ~/unifi-controller/ && podman-compose pull

# Stop systemd service, which will stop container
systemctl --user stop container-unifi-controller.service

# Remove pod and container
podman pod ps
podman pod rm <pod ID>
podman ps
podman rm <container ID>

# Recreate container with latest image 
podman-compose up -d

# Not sure if necessary, but regenerate systemd unit file too
podman generate systemd --restart-policy always --name unifi-controller > ~/.config/systemd/user/container-unifi-controller.service

```

## References

* [Arch Linux wiki - podman](https://wiki.archlinux.org/title/Podman)
* [Rootless podman containers under system accounts, managed and enabled at boot with systemd](https://blog.christophersmart.com/2021/02/20/rootless-podman-containers-under-system-accounts-managed-and-enabled-at-boot-with-systemd/)
* [Rootless Containers in 2020 on Arch Linux](https://vadosware.io/post/rootless-containers-in-2020-on-arch-linux/)
* [docker-unifi-controller project](https://github.com/linuxserver/docker-unifi-controller)