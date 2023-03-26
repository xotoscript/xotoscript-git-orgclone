#!/bin/bash

WHITE="\033[1;37m"
RED="\033[0;31m"
RESET_COLOR="\033[0m"
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

################## ARGUMENTS

while [ ! -z "$1" ]; do
	case "$1" in
	--username | -n)
		shift
		USERNAME=$1
		;;
	--token | -c)
		shift
		TOKEN=$1
		;;
	--organization | -c)
		shift
		ORGANIZATION=$1
		;;
	--clean | -c)
		shift
		CLEAN=$1
		;;
	*) ;;
	esac
	shift
done

################## DIRECTORY

if [[ -d "$ORGANIZATION" ]]; then
	rm -rf $ORGANIZATION
fi

################## CLONING

mkdir "${ORGANIZATION}"
cd "${ORGANIZATION}"
ORG_PATH=$(pwd)

echo -e "${GREEN}organization => ${YELLOW}${ORGANIZATION} ${GREEN}has repos => cloning${RESET_COLOR}"
echo ""

curl -X GET -u $USERNAME:$TOKEN https://api.github.com/orgs/${ORGANIZATION}/repos | jq -r '.[]|.ssh_url' | xargs -L1 git clone

################## CLEAN

if [ "$CLEAN" = true ]; then

	echo ""
	echo -e "${GREEN}====================================================${RESET_COLOR}"
	echo -e "${YELLOW}# cleaning organization ${GREEN}${ORGANIZATION} ${YELLOW}with username ${GREEN}$USERNAME ${WHITE} token ${GREEN}$TOKEN ${WHITE}${RESET_COLOR}"
	echo -e "${GREEN}====================================================${RESET_COLOR}"
	echo ""

	declare -a currentOrgRepo=($(curl -X GET -u $USERNAME:$TOKEN https://api.github.com/orgs/${ORGANIZATION}/repos | jq -r '.[]|.name'))
	for ((j = 0; j < ${#currentOrgRepo[@]}; j++)); do
		cd "${currentOrgRepo[$j]}"
		echo -e "${YELLOW}cleaning repo => ${RED}${currentOrgRepo[$j]}${RESET_COLOR}"
		echo ""
		wget -qO- https://raw.githubusercontent.com/xotoscript/xotoscript-git-reporeset/development/install.sh | bash -s -- --username $USERNAME
		cd "${ORG_PATH}"
		echo ""
	done
fi
