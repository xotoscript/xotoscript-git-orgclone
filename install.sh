source bootstrap.sh

WHITE="\033[1;37m"
RED="\033[0;31m"
RESET_COLOR="\033[0m"
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

declare -a organizations=(
	"xotoboil"
	"xotocred"
	"xotocrypt"
	"xotodesign"
	"xotodev"
	"xotoenv"
	"xotomachine"
	"xotomicro"
	"xotopedia"
	"xotopost"
	"xotoprod"
	"xotoscript"
	"xotoshare"
	"xototemp"
	"xotoverse"
	"xotoprog"
)

CWD=$(pwd)

arraylength=${#organizations[@]}

for ((i = 0; i < ${arraylength}; i++)); do
	echo ""
	echo -e "${GREEN}cloning from : ${organizations[$i]}${RESET_COLOR}"
	mkdir "${organizations[$i]}"
	cd "${organizations[$i]}"
	curl -X GET -u $USERNAME:$TOKEN https://api.github.com/orgs/${organizations[$i]}/repos | jq -r '.[]|.ssh_url' | xargs -L1 git clone
	# curl -u $USERNAME https://api.github.com/orgs/${org}/repos | jq -r '.[]|.ssh_url' | xargs -L1 git clone
	cd "${CWD}"
done
