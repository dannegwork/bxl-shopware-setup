#!/bin/bash

docker-compose run --rm shopware install
docker-compose run --rm ant /bin/bash configure
docker-compose run --rm ant /bin/bash build-unit