FROM node:slim
RUN apt update -y
RUN apt install git -y
USER node
ENV HOME /home/node
WORKDIR $HOME
ENTRYPOINT ["bash", "-c", "$1;. auth.sh $0; $SHELL"] 