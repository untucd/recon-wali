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

mkdir -p output/$domain

echo "${BLUE} ######################################################### ${RESET}"
echo "${BLUE} #                   Finding Subdomains                  # ${RESET}"
echo "${BLUE} ######################################################### ${RESET}"

sublist3r -d $domain -v -o output/$domain/op.txt
subfinder -d $domain -o output/$domain/op.txt
assetfinder --subs-only $domain | tee -a output/$domain/op.txt

curl -s https://crt.sh/\?q\=$domain\&output\=json | jq &>/dev/null | awk -F'"' '/value/{print $4}' | sed 's/*.//g;s/\\n/\n/g' | sed 's/ /\n/g' | tee -a output/$domain/op.txt
curl -s https://otx.alienvault.com/api/v1/indicators/domain/$domain/passive_dns | jq &>/dev/null | awk -F': ' '/"hostname": "(.*'$domain')"/{print $2}' | sed 's/[",]//g' | sed 's/ /\n/g' | tee -a output/$domain/op.txt
curl -s https://dns.bufferover.run/dns\?q\=.$domain | awk -F',' '/.*'$domain'/{print $2}' | sed 's/"//g' | sed 's/ /\n/g' | tee -a output/$domain/op.txt
curl -s http://api.hackertarget.com/hostsearch/\?q\=$domain | cut -d',' -f1 | sed 's/ /\n/g' | tee -a output/$domain/op.txt
curl -s https://rapiddns.io/subdomain/$domain\?full\=1 | awk -F'">' '/'$domain'/{print $2}' | cut -d'<' -f1 | awk 'NF' | sed 's/ /\n/g' | tee -a output/$domain/op.txt
curl -s https://api.sublist3r.com/search.php\?domain\=$domain | jq &>/dev/null | awk -F'"' '/'$domain'/{print $2}' | sed 's/ /\n/g' | tee -a output/$domain/op.txt
curl -s https://www.threatcrowd.org/searchApi/v2/domain/report/\?domain\=$domain | jq &>/dev/null | awk -F'"' '/\.'$domain'/{print $2}' | sed 's/ //g' | sed 's/ /\n/g' | tee -a output/$domain/op.txt


amass enum -passive -d $doamin | tee -a output/$domain/op.txt

(amass enum -active -d $domain -ip | tee -a output/$domain/amass_ips.txt) & pid=$!
sleep 18000 && kill "$pid" && sleep 20
cat output/$domain/amass_ips.txt | awk '{print $1}' | tee -a output/$domain/op.txt

cat output/$domain/op.txt | sort -u | tee -a output/$domain/all.txt
