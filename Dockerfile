FROM node:slim
RUN apt update -y
RUN apt install git -y
USER node
ENV HOME /home/node
WORKDIR $HOME