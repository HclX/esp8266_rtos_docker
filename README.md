# esp8266_rtos_docker
A docker container to build ESP_8266_RTOS_SDK based projects.

To build the image, run "docker build . -t esp8266_rtos_sdk"
To build a project, run "docker run -v <path_to_project>:/project esp8266_rtos_sdk make -C /project <target>"
