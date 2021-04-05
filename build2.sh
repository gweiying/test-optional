#!/bin/bash 

#################################################################
# Override netlify.toml with centrally-hosted netlify.toml file #
#################################################################
curl https://raw.githubusercontent.com/opengovsg/isomer-build/master/netlify.toml -o /opt/build/repo/netlify.toml

###############################################################
# Generate build script for Jekyll v4 collections structure   #
###############################################################
# search within all collections for collection.yml file
collections=$(find . -path ./_site -prune -false -o -name collection.yml -type f)
var=$(echo $collections | sed 's/ .\//,.\//g')

env='development'
while getopts "e:" opt; do
  case $opt in
    e) env=$OPTARG      ;;
    *) echo 'error' >&2
       exit 1
  esac
done

# netlify build
echo "env:"$env
JEKYLL_ENV=$env jekyll build --config _config.yml",$var"
