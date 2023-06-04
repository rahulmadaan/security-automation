#! /bin/bash

file=$(cat /tmp/config.yaml)

host=$(echo "$file" | yq ".sonarqube.host")
project_name=$(echo "$file" | yq ".sonarqube.project_name")
token=$(echo "$file" | yq ".sonarqube.token")
project_path=$(echo "$file" | yq ".sonarqube.project_path")
show_logs=$(echo "$file" | yq ".sonarqube.show_logs")

LOG_REDIRECTION="/dev/tty"
if [ $show_logs == "false" ]; then
  LOG_REDIRECTION="/dev/null"
fi

sonar-scanner \
  -Dsonar.projectKey=$project_name \
  -Dsonar.sources=$project_path \
  -Dsonar.host.url=$host \
  -Dsonar.login=$token > $LOG_REDIRECTION



echo "security checks ran successfully !!!"