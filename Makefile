DOCKER_NAME=hugo
DOCKER_TAG=archlinux
VOLUME_DIR=/tmp/${DOCKER_NAME}-${DOCKER_TAG}
PORT=1313

all: build run

volume:
	mkdir -p ${VOLUME_DIR}

volume_clean:
	rm -rf ${VOLUME_DIR}

build:
	docker build -t ${DOCKER_NAME}:${DOCKER_TAG} .

run:
	docker run --rm -it -p ${PORT}:1313 -v ${VOLUME_DIR}:/mnt/data --hostname=${DOCKER_NAME}-${DOCKER_TAG} ${DOCKER_NAME}:${DOCKER_TAG}

clean: volume_clean
	docker image rm ${DOCKER_NAME}:${DOCKER_TAG}
