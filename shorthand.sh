#! /bin/bash

# new
alias c=clear;
dcRun() { docker-compose run $1-service $2; };

# deprecated
alias dcUp="docker-compose up -d";
alias dcDown="docker-compose down";
alias dPrune="docker system prune --force";
alias dcKill="docker-compose kill";
alias dcBuild="docker-compose build";

dcIn() { docker-compose exec $1-service bash; };

# confirmation
echo "Shorthands Added!";