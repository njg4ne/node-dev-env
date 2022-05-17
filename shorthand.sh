#! /bin/bash

alias c=clear;
alias dcUp="docker-compose up -d";
alias dcDown="docker-compose down";
alias dPrune="docker system prune --force";
alias dcKill="docker-compose kill";
alias dcRestart="dcDown; dcUp; dcIn $1;";
alias dcBuild="docker-compose build"
alias nodeline="docker-compose run dev-service"

dcIn() { docker-compose exec $1-service bash; };

echo "Shorthands Added!";