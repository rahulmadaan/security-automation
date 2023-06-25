#! /bin/bash

file=$(cat /tmp/config.yaml)

host=$(echo "$file" | yq ".sonarqube.host")
project_path=$(echo "$file" | yq ".sonarqube.project_path")
show_logs=$(echo "$file" | yq ".sonarqube.show_logs")

LOG_REDIRECTION="/dev/tty"
if [ $show_logs == "false" ]; then
  LOG_REDIRECTION="/dev/null"
fi

sonar-scanner \
  -Dproject.settings=$project_path/sonar-project.properties \
  -Dsonar.host.url=$host \
  -Dsonar.sources=$project_path > $LOG_REDIRECTION


echo "security checks ran successfully !!!"