# Overview
Flume is a distributed, reliable, and available service for efficiently collecting, aggregating, and moving large amounts of log data. Further details can be found in https://flume.apache.org/

We provide a lean image based on Alpine which just uses 230.4 MB

# Configuration
You need to provide your specific configuration file in the following mapped volume. Details how to configure flume are at https://flume.apache.org/FlumeUserGuide.html:
- VOLUME /flume/conf (for your configuration files (log4.ini and flume.conf)

The following volume can be mapped if you have any custom extensions
- VOLUME /flume/plugins.d (for your custom extensions)

And the following environment parameters can be adjusted to your needs
- ENV AGENT=agent
- ENV CONFIG=flume.conf
- ENV LOGGER=INFO,console

The architecture of Flume is fitting nicely to be started as Docker Swarm service.

# Docker Compose
I am starting my container with the following docker compose file:

    version: '2'
    services:
      flume:
      image: pschatzmann/flume
      container_name: flume
      volumes:
        - /srv/flume/plugins.d:/flume/plugins.d
        - /srv/flume/conf:/flume/conf
      restart: always
      environment:
        - LOGGER=INFO,console
