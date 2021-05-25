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

echo "${GREEN} ######################################################### ${RESET}"
echo "${GREEN} #                Subdomain Bruteforcing                 # ${RESET}"
echo "${GREEN} ######################################################### ${RESET}"


(altdns -i output/$domain/all.txt -o output/$domain/data_output -w ~/tools/recon/patterns.txt -r -s output/$domain/results_output.txt -t 250) & pid=$!
sleep 18000 && kill "$pid" && sleep 20

mv output/$domain/results_output.txt output/$domain/dns_op.txt
cat output/$domain/dns_op.txt > output/$domain/output.txt
cat output/$domain/output.txt | awk -F ":" '{print $1}' | sort -u | tee -a output/$domain/all.txt
