FROM debian:wheezy
MAINTAINER Thomas Fricke <thomas@endocode.com>

#Base image doesn't start in root
WORKDIR /

RUN apt-get update && apt-get upgrade -y && apt-get install -y wget unzip procps lsof sudo
#Add the CDH 5 repository
COPY conf/cloudera.list /etc/apt/sources.list.d/cloudera.list
#Set preference for cloudera packages
COPY conf/cloudera.pref /etc/apt/preferences.d/cloudera.pref

COPY conf/webupd8team-java.list /etc/apt/sources.list.d/webupd8team-java.list

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
#Add a Repository Key
RUN wget http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key -O archive.key 
RUN apt-key add archive.key 
RUN apt-get update

#Install CDH package
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
   echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
   apt-get install -y oracle-java7-installer && \
   apt-get install -y zookeeper-server hadoop-conf-pseudo oozie pig hive hive-metastore

#Copy updated config files
COPY conf/core-site.xml /etc/hadoop/conf/core-site.xml
COPY conf/hdfs-site.xml /etc/hadoop/conf/hdfs-site.xml
COPY conf/mapred-site.xml /etc/hadoop/conf/mapred-site.xml
COPY conf/hadoop-env.sh /etc/hadoop/conf/hadoop-env.sh
COPY conf/yarn-site.xml /etc/hadoop/conf/yarn-site.xml
COPY conf/hive-site.xml /etc/hive/conf/hive-site.xml

#Format HDFS
RUN sudo -u hdfs hdfs namenode -format

COPY conf/run-hadoop.sh /usr/bin/run-hadoop.sh
RUN chmod +x /usr/bin/run-hadoop.sh

RUN sudo -u oozie /usr/lib/oozie/bin/ooziedb.sh create -run && \
    wget http://archive.cloudera.com/gplextras/misc/ext-2.2.zip -O ext.zip && \
    unzip ext.zip -d /var/lib/oozie

# NameNode (HDFS)
EXPOSE 8020 50070

# DataNode (HDFS)
EXPOSE 50010 50020 50075

# ResourceManager (YARN)
EXPOSE 8030 8031 8032 8033 8088

# NodeManager (YARN)
EXPOSE 8040 8042

# JobHistoryServer
EXPOSE 10020 19888

CMD ["/usr/bin/run-hadoop.sh"]
