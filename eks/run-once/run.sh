#!/bin/bash
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'
bold=$(tput bold)
normal=$(tput sgr0)

printf "%s\n" "${bold}${grn}Installing aws sdk... ${end}${normal}"

curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

pip3 install awscli --upgrade --user

printf "%s\n" "${bold}${yel}AWS SDK successfully installed.${end}${normal}"

printf "%s\n" "${bold}${grn}Setting up aws keys... ${end}${normal}"

aws configure

printf "%s\n" "${bold}${yel}AWS Keys succesfully configured${end}${normal}"

printf "%s\n" "${bold}${grn}Installing eksctl... ${end}${normal}"

brew tap weaveworks/tap

brew install weaveworks/tap/eksctl

brew upgrade eksctl && brew link --overwrite eksctl

printf "%s\n" "${bold}${yel}eksctl succesfully installed${end}${normal}"

printf "%s\n" "${bold}${grn}Installing kubectl... ${end}${normal}"

brew install kubectl

printf "%s\n" "${bold}${yel}kubectl successfully installed${end}${normal}"

printf "%s\n" "${bold}${grn}Installing tektoncd-cli... ${end}${normal}"

brew install tektoncd-cli

printf "%s\n" "${bold}${yel}tektoncd-cli successfully installed${end}${normal}"


printf "%s\n" "${bold}${grn}Installing linkerd... ${end}${normal}"

brew install linkerd

printf "%s\n" "${bold}${yel}linkerd successfully installed${end}${normal}"
