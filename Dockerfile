FROM centos
RUN yum install git -y
RUN touch /tmp/devops
ENTRYPOINT ["echo", "hello world"]
