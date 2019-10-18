# docker-rpi-motioneye
Docker image for running [motionEye](https://github.com/ccrisan/motioneye) on a Raspberry Pi

# Deprecated
It now appears that there is an official image for armhf. Check out the instructions on the motionEye wiki https://github.com/ccrisan/motioneye/wiki/Install-in-Docker

## motionEye
Here is what the author has to say about motionEye:

> motionEye is a web frontend for the motion daemon, written in Python.

Very succinct! This project is just a Docker container that makes it easy to deploy motionEye on your Raspberry Pi.

## Getting Docker on your Raspberry Pi
I recommend checking out [Hypriot](http://blog.hypriot.com/) and their [Getting Started](http://blog.hypriot.com/getting-started-with-docker-on-your-arm-device/) guide

## Running
This image is hosted on Docker Hub tagged as [vividboarder/rpi-motioneye](https://hub.docker.com/r/vividboarder/rpi-motioneye/), so you can feel free to use the `docker-compose.yaml` and change `build: .` to `image: vividboarder/rpi-motioneye`. After that, `docker-compose up` should get you started.

Alternately, you can compile the image yourself by cloning this repo and using `docker-compose`

```
docker-compose up
```

If you want a little more control, you can use any of the make targets:

```
make build  # builds a new image
make run    # builds and runs container using same parameters as compose
make shell  # builds and runs an interractive container
make tag    # tags image to be pushed to docker hub
make push   # pushes image to docker hub
```

## Issues?
Feel free to report any issues you're having getting this to run on [Github](https://github.com/ViViDboarder/docker-rpi-motioneye/issues)
