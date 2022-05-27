FROM node:slim as node-base
RUN apt update -y
RUN apt install git -y
RUN echo 'root:dock' | chpasswd
USER node
ENV NODEHOME /home/node
WORKDIR $NODEHOME

FROM node-base as vanilla
USER root
RUN npm install live-server --global
USER node

FROM node-base as react-vite
USER root 
RUN apt install xdg-utils -y
USER node

FROM node-base as node-git
ENTRYPOINT ["bash", "-c", "$0; $SHELL", "cp gitfile .gitconfig" ]

FROM react-vite as node
ENTRYPOINT ["bash", "-c", "$0;. auth.sh $NODEHOME/.ssh/$KEYNAME; $SHELL", "cp gitfile .gitconfig" ]