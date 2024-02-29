FROM aiplanning/planutils:latest

LABEL maintainer="Giovanni Perantoni (giovanni.perantoni@studenti.unitn.it)"

# Install solvers and tools
RUN planutils install -y downward
RUN planutils install -y ff
RUN planutils install -y optic
RUN planutils install -y tfd
