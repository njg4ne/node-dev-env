#! /bin/bash

# new
alias c=clear;



# deprecated
alias dcUpAll="docker-compose up -d";
alias dcDown="docker-compose down";
alias dPrune="docker system prune --force";
alias dcKill="docker-compose kill";
alias dcBuildAll="docker-compose build";

dcIn() { docker attach $1-container; };

dcBuild() {  docker-compose build $1-service; };

dcGit() { docker-compose run --rm -e KEYNAME=$1 git-service; };
dcStand() { dcUpAll $1-service; };
dcDev() { dcStand $1; dcIn $1; };

dcRun() { docker-compose run $1-service; };



# confirmation
echo "Shorthands Added!";