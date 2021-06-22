FROM jenkins/jenkins:lts
USER root
RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli \
        maven
WORKDIR /var/jenkins_home
USER jenkins
#RUN jenkins-plugin-cli --plugins "blueocean:1.24.5 docker-plugin:1.2.2 docker-workflow:1.26 sonar:2.13 gitlab-plugin:1.5.20 nexus-jenkins-plugin:3.11.20210323-112924.daaeac7"
RUN jenkins-plugin-cli --plugins "blueocean docker-plugin docker-workflow sonar gitlab-plugin nexus-jenkins-plugin"
