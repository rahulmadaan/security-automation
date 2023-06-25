#! /bin/bash

file=$(cat /tmp/config.yaml)

host=$(echo "$file" | yq ".sonarqube.host")
project_path=$(echo "$file" | yq ".sonarqube.project_path")
input_properties_file_name=$(echo "$file" | yq ".sonarqube.project_properties_file")
show_logs=$(echo "$file" | yq ".sonarqube.show_logs")

LOG_REDIRECTION="/dev/tty"
if [ $show_logs != "" ]; then
  LOG_REDIRECTION="/dev/null"
fi

PROJECT_PROPERTIES_FILE="sonar-project.properties"
if [ $input_properties_file_name != "" ]; then
  PROJECT_PROPERTIES_FILE="$input_properties_file_name"
fi

sonar-scanner \
  -Dproject.settings=$project_path/$PROJECT_PROPERTIES_FILE \
  -Dsonar.host.url=$host \
  -Dsonar.sources=$project_path > $LOG_REDIRECTION


echo "security checks ran successfully !!!"