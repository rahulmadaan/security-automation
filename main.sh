#! /bin/bash

file=$(cat /tmp/config.yaml)

host=$(echo "$file" | yq ".sonarqube.host")
project_name=$(echo "$file" | yq ".sonarqube.project_name")
token=$(echo "$file" | yq ".sonarqube.token")
project_path=$(echo "$file" | yq ".sonarqube.project_path")

sonar-scanner \
  -Dsonar.projectKey=$project_name \
  -Dsonar.sources=$project_path \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token


echo "security checks ran successfully !!!"