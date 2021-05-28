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
echo "${BLUE} #              Checking for alive subdomains            # ${RESET}"
echo "${BLUE} ######################################################### ${RESET}"



mkdir -p output/$domain/nuclei_op/
nuclei -l output/$domain/alive.txt -t "~/tools/nuclei-templates/cves/" -c 100 -o output/$domain/nuclei_op/cves.txt
nuclei -l output/$domain/alive.txt -t "~/tools/nuclei-templates/default-logins/" -c 100 -o output/$domain/nuclei_op/default-logins.txt
nuclei -l output/$domain/alive.txt -t "~/tools/nuclei-templates/dns/" -c 100 -o output/$domain/nuclei_op/dns.txt
nuclei -l output/$domain/alive.txt -t "~/tools/nuclei-templates/exposed-panels/" -c 100 -o output/$domain/nuclei_op/exposed-panels.txt
nuclei -l output/$domain/alive.txt -t "~/tools/nuclei-templates/exposed-tokens/" -c 100 -o output/$domain/nuclei_op/exposed-tokens.txt
nuclei -l output/$domain/alive.txt -t "~/tools/nuclei-templates/exposures/" -c 100 -o output/$domain/nuclei_op/exposures.txt
nuclei -l output/$domain/alive.txt -t "~/tools/nuclei-templates/fuzzing/" -c 100 -o output/$domain/nuclei_op/fuzzing.txt
nuclei -l output/$domain/alive.txt -t "~/tools/nuclei-templates/helpers/" -c 100 -o output/$domain/nuclei_op/helpers.txt
nuclei -l output/$domain/alive.txt -t "~/tools/nuclei-templates/miscellaneous/" -c 100 -o output/$domain/nuclei_op/miscellaneous.txt
nuclei -l output/$domain/alive.txt -t "~/tools/nuclei-templates/misconfiguration/" -c 100 -o output/$domain/nuclei_op/misconfiguration.txt
nuclei -l output/$domain/alive.txt -t "~/tools/nuclei-templates/takeovers/" -c 100 -o output/$domain/nuclei_op/takeovers.txt
nuclei -l output/$domain/alive.txt -t "~/tools/nuclei-templates/technologies/" -c 100 -o output/$domain/nuclei_op/technologies.txt
nuclei -l output/$domain/alive.txt -t "~/tools/nuclei-templates/vulnerabilities/" -c 100 -o output/$domain/nuclei_op/vulnerabilities.txt
nuclei -l output/$domain/alive.txt -t "~/tools/nuclei-templates/workflows/" -c 100 -o output/$domain/nuclei_op/workflows.txt


# (cat output/$domain/naabu_portscan.txt | httprobe -c 100 | tee -a output/$domain/alive2.txt) & pid=$!

# time=0
# # check if time is less than 5 hrs and process is also running
# while [[ $time -le 18000 ]] && ps -p $pid > /dev/null; do
#         sleep 20
#         time=$((time+20))
# done

# if ps -p $pid > /dev/null; then kill $pid; fi
