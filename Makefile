default: build

# Default target to build the image
build:
	docker build -t rpi-motioneye-dev .

# Target to build and run and subsequently remove image
run: build
	docker run --rm \
		-p "localhost:8765:8765"
		-v "recordings:/var/lib/motioneye" \
		rpi-motioneye-dev

# Target to drop into an interractive shell
shell: build
	docker run --rm \
		-p "localhost:8765:8765"
		-v "recordings:/var/lib/motioneye" \
		-it rpi-motioneye-dev bash

# Tags dev image so it can be pushed
tag: build
	docker tag rpi-motioneye-dev vividboarder/rpi-motioneye

# Pushes tagged image to docker hub
push: tag
	docker push vividboarder/rpi-motioneye
