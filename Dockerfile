FROM jenkins/jenkins:lts-jdk11
# if we want to install via apt
USER root
RUN apt-get update && apt-get install -y python3 sudo curl make g++ build-essential
RUN bash -c "sudo ln -s /usr/bin/python3 /usr/bin/python"
RUN echo "jenkins:jenkins" | chpasswd
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER jenkins
