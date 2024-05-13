#!/bin/bash

./build-image.sh '' romeujr/base_application ./dockerfile-base_application.txt '' '__=_'
./build-image.sh 'romeujr/base_application' romeujr/nginx ./dockerfile-nginx.txt '' '__=_'
./build-image.sh 'romeujr/base_application' romeujr/postgres ./dockerfile-postgres.txt '' '__=_'