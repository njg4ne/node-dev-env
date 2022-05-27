#! /bin/bash

# new
alias c=clear;

dcGit() { docker-compose run --rm -e KEYNAME=$1 git-service; };
dcDev() { dcUp $1-service; docker attach $1-container; };

dcRun() { docker-compose run $1-service; };

# deprecated
alias dcUp="docker-compose up -d";
alias dcDown="docker-compose down";
alias dPrune="docker system prune --force";
alias dcKill="docker-compose kill";
alias dcBuild="docker-compose build";

dcIn() { docker-compose exec $1-service bash; };

# confirmation
echo "Shorthands Added!";