FROM aiplanning/planutils:latest

LABEL maintainer="Giovanni Perantoni (giovanni.perantoni@studenti.unitn.it)"

# Install solvers and tools
RUN planutils install -y downward
RUN planutils install -y ff
RUN planutils install -y optic
RUN planutils install -y tfd

RUN apt-get update
RUN apt-get install -y openjdk-21-jre openjdk-21-jre-headless

# sudo docker build -t automated_planning .
# alias planning_docker="sudo docker run --rm -it -v /home/giovanniperantoni/automated_planning/:/root/shared --privileged automated_planning bash"
