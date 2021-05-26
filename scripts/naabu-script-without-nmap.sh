source ~/.bash_profile

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

echo "${RED} ######################################################### ${RESET}"
echo "${RED} #                         Let's Hunt                    # ${RESET}"
echo "${RED} ######################################################### ${RESET}"

while getopts ":d:" input; do
        case "$input" in
        d)
                domain=${OPTARG}
                ;;
        esac
done
if [ -z "$domain" ]; then
        echo "${BLUE}Please give a domain like \"-d domain.com\"${RESET}"
        exit 1
fi

echo "${BLUE} ######################################################### ${RESET}"
echo "${BLUE} #                      Running Naabu                    # ${RESET}"
echo "${BLUE} ######################################################### ${RESET}"

naabu -iL output/$domain/all.txt -c 80 -p - -o output/$domain/naabu_portscan.txt
