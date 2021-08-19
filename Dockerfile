FROM jenkins/jenkins:lts

# Unlock root previleges 
USER root
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        wget \
        curl \
        vim \
    && rm -rf /var/lib/apt/lists/*

# Install nvm with node and npm
RUN bash \
  && apt-get update \
  && apt-get install sudo \
  && sudo usermod -a -G sudo jenkins 
  
USER jenkins  
ENV NODE_VERSION 14.16.1 

RUN cd /var/jenkins_home \
  && touch .bashrc \
  && mkdir -p /var/jenkins_home/.nvm/versions \
  && chmod +x .bashrc 


RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash 
COPY setup.sh /var/jenkins_home/setup.sh
RUN /var/jenkins_home/setup.sh

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Jenkins Configuration as Code
COPY casc.yaml /var/jenkins_home/casc.yaml
