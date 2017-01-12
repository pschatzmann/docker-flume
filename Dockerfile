FROM java:alpine
MAINTAINER Phil Schatzmann <pschatzmann@gmail.com>
ENV FLUME_HOME=/flume
ENV AGENT=agent
ENV CONFIG=flume.conf
ENV LOGGER=INFO,console
RUN apk add --no-cache bash tar 
RUN mkdir -p $FLUME_HOME
RUN mkdir -p $FLUME_HOME/plugins.d
WORKDIR $FLUME_HOME
RUN wget -qO- http://archive.apache.org/dist/flume/1.6.0/apache-flume-1.6.0-bin.tar.gz \
  | tar zxvf - -C $FLUME_HOME --strip 1
ADD flume.conf $FLUME_HOME/conf/flume.conf
VOLUME $FLUME_HOME/conf
VOLUME $FLUME_HOME/plugins.d
CMD bin/flume-ng agent --conf $FLUME_HOME/conf -f $FLUME_HOME/conf/$CONFIG -n $AGENT -Dflume.root.logger=$LOGGER

