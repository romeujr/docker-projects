#!/bin/bash

set -e

./build-image.sh ""                          "romeujr/base_application"                         ./dockerfile-base_application.txt ""                              "__=_"
# ./build-image.sh "romeujr/base_application"  "romeujr/nginx"                                    ./dockerfile-nginx.txt            ""                              "__=_"
# ./build-image.sh "romeujr/base_application"  "romeujr/postgres"                                 ./dockerfile-postgres.txt         ""                              "__=_"

./build-image.sh "romeujr/base_application"  "romeujr/dotnet_web"                               ./dockerfile-dotnet.txt           ""                              "DOTNET_ARGS=--runtime aspnetcore --channel 8.0"
./build-image.sh "romeujr/dotnet_web"        "romeujr/dotnet_web-nginx"                         ./dockerfile-nginx.txt            ""                              "__=_"
./build-image.sh "romeujr/dotnet_web-nginx"  "romeujr/dotnet_web-nginx-ollama"                  ./dockerfile-ollama.txt           ""                              "__=_"
# ./build-image.sh "romeujr/dotnet_web-nginx"  "romeujr/dotnet_web-nginx-postgres"                ./dockerfile-postgres.txt         ""                              "__=_"

# ./build-image.sh "romeujr/base_application"  "romeujr/dotnet_sdk"                               ./dockerfile-dotnet.txt           ""                              "DOTNET_ARGS=--channel 8.0"
# ./build-image.sh "romeujr/dotnet_sdk"        "romeujr/devops-aws-dotnet_sdk-git-nodejs-python"  ./dockerfile-nodejs.txt           "awscli git python3 zip unzip"  "NODEJS_ARGS=20"
