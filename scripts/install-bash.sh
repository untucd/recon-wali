#!/bin/bash
sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y libpcap-dev
sudo apt-get install -y jq
sudo apt-get install -y ruby-full
sudo apt-get install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev
sudo apt-get install -y python-setuptools
sudo apt-get install -y libldns-dev
sudo apt-get install -y python3-pip
sudo apt-get install -y python-pip
sudo apt-get install -y python-dnspython
sudo apt-get install -y git
sudo apt-get install -y rename
sudo apt-get install -y xargs
sudo apt-get install -y whatweb
sudo apt-get install -y nikto
sudo apt-get install gcc libpq-dev -y
sudo apt-get install python-dev  python-pip -y
sudo apt-get install python3-dev python3-pip python3-venv python3-wheel -y
sudo snap install amass

echo -e "\e[1;31m installing bash_profile aliases from recon_profile \e[0m"
git clone https://github.com/NetanMangal/recon_profile.git
cd recon_profile
cat .bash_profile >>~/.bash_profile
source ~/.bash_profile
echo -e "\e[1;31m done \e[0m"

echo "" >> ~/.bashrc
echo "" >> ~/.bashrc
echo "if [ -f ~/.bash_profile ]; then" >> ~/.bashrc
echo "    . ~/.bash_profile" >> ~/.bashrc
echo "fi" >> ~/.bashrc


#install go
if [[ -z "$GOPATH" ]]; then
	echo -e "\e[1;31m Installing Golang \e[0m"
	wget https://dl.google.com/go/go1.15.6.linux-amd64.tar.gz
	sudo tar -xf go1.15.6.linux-amd64.tar.gz
	sudo mv go /usr/local
	export GOROOT=/usr/local/go
	export GOPATH=$HOME/go
	export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
	echo 'export GOROOT=/usr/local/go' >>~/.bash_profile
	echo 'export GOPATH=$HOME/go' >>~/.bash_profile
	echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >>~/.bash_profile
	source ~/.bash_profile
	sleep 1
else
	echo -e "\e[1;31m Go already installed \e[0m"
fi

#Don't forget to set up AWS credentials!
echo -e "\e[1;31m Don't forget to set up AWS credentials! \e[0m"
sudo apt-get install -y awscli
echo -e "\e[1;31m Don't forget to set up AWS credentials! \e[0m"

#create a tools folder in ~/
mkdir ~/tools
cd ~/tools/

#install aquatone
echo -e "\e[1;31m Installing Aquatone \e[0m"
go get github.com/michenriksen/aquatone
echo -e "\e[1;31m done \e[0m"

#install chromium
echo -e "\e[1;31m Installing Chromium \e[0m"
sudo snap install chromium
echo -e "\e[1;31m done \e[0m"

#install nmap
echo -e "\e[1;31m installing nmap \e[0m"
sudo apt-get install -y nmap
echo -e "\e[1;31m done \e[0m"

#nmap scripts
sudo cd /usr/share/nmap/
sudo git clone https://github.com/scipag/vulscan scipag_vulscan
sudo ln -s `pwd`/scipag_vulscan /usr/share/nmap/scripts/vulscan

#nmap scripts
cd /usr/share/nmap/scripts/
git clone https://github.com/vulnersCom/nmap-vulners.git
cd ~/tools/

#install JSParser
echo -e "\e[1;31m installing JSParser \e[0m"
git clone https://github.com/nahamsec/JSParser.git
cd JSParser*
pip install wheel
sudo python setup.py install
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install Sublist3r
echo -e "\e[1;31m installing Sublist3r \e[0m"
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r*
pip install -r requirements.txt
sudo ln -sfv /home/runner/tools/Sublist3r/sublist3r.py /usr/bin/sublist3r
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install Interlace
echo -e "\e[1;31m installing Interlace \e[0m"
git clone https://github.com/codingo/Interlace.git
cd Interlace
python3 setup.py install
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install teh_s3_bucketeers
echo -e "\e[1;31m installing teh_s3_bucketeers \e[0m"
git clone https://github.com/tomdev/teh_s3_bucketeers.git
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install dirsearch
echo -e "\e[1;31m installing dirsearch \e[0m"
git clone https://github.com/maurosoria/dirsearch.git
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install lazys3
echo -e "\e[1;31m installing lazys3 \e[0m"
git clone https://github.com/nahamsec/lazys3.git
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install virtual host discovery
echo -e "\e[1;31m installing virtual host discovery \e[0m"
git clone https://github.com/jobertabma/virtual-host-discovery.git
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install sqlmap
echo -e "\e[1;31m installing sqlmap \e[0m"
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install knock.py
echo -e "\e[1;31m installing knock.py \e[0m"
git clone https://github.com/guelfoweb/knock.git
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install lazyrecon
echo -e "\e[1;31m installing lazyrecon \e[0m"
git clone https://github.com/nahamsec/lazyrecon.git
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install massdns
echo -e "\e[1;31m installing massdns \e[0m"
git clone https://github.com/blechschmidt/massdns.git
cd ~/tools/massdns
make
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install asnlookup
echo -e "\e[1;31m installing asnlookup \e[0m"
git clone https://github.com/yassineaboukir/asnlookup.git
cd ~/tools/asnlookup
pip install -r requirements.txt
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install Corsy
echo -e "\e[1;31m installing Corsy \e[0m"
git clone https://github.com/s0md3v/Corsy.git
cd ~/tools/Corsy
pip3 install -r requirements.txt
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install Nuclei
echo -e "\e[1;31m installing Nuclei \e[0m"
GO111MODULE=on go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
nuclei -update-templates
mv ~/nuclei-templates/ ~/tools/
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install crtndstry
echo -e "\e[1;31m installing crtndstry \e[0m"
git clone https://github.com/nahamsec/crtndstry.git
echo -e "\e[1;31m done \e[0m"

#install Seclists
echo -e "\e[1;31m downloading Seclists \e[0m"
cd ~/tools/
git clone --depth 1 https://github.com/danielmiessler/SecLists.git
cd ~/tools/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 >clean-jhaddix-dns.txt
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install NetanMangal/recon
echo -e "\e[1;31m installing NetanMangal/recon \e[0m"
git clone https://github.com/NetanMangal/recon.git
echo -e "\e[1;31m done \e[0m"

#install smuggler.py
echo -e "\e[1;31m installing smuggler.py \e[0m"
git clone https://github.com/defparam/smuggler.git
sudo ln -sfv /home/runner/tools/smuggler/smuggler.py /usr/bin/smuggler
echo -e "\e[1;31m done \e[0m"

#install relative-url-extractor
echo -e "\e[1;31m installing relative-url-extractor \e[0m"
git clone https://github.com/jobertabma/relative-url-extractor.git
echo -e "\e[1;31m done \e[0m"

#install altdns
echo -e "\e[1;31m installing altdns \e[0m"
cd ~/tools/
pip install wheel
pip install py-altdns
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

#install httprobe
echo -e "\e[1;31m installing httprobe \e[0m"
go get -u github.com/tomnomnom/httprobe
echo -e "\e[1;31m done \e[0m"

#install assetfinder
echo -e "\e[1;31m installing assetfinder \e[0m"
go get -u github.com/tomnomnom/assetfinder
echo -e "\e[1;31m done \e[0m"

#install unfurl
echo -e "\e[1;31m installing unfurl \e[0m"
go get -u github.com/tomnomnom/unfurl
echo -e "\e[1;31m done \e[0m"

#install waybackurls
echo -e "\e[1;31m installing waybackurls \e[0m"
go get -u github.com/tomnomnom/waybackurls
echo -e "\e[1;31m done \e[0m"

#install subfinder
echo -e "\e[1;31m installing subfinder \e[0m"
GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
echo -e "\e[1;31m done \e[0m"

#install naabu
echo -e "\e[1;31m installing naabu \e[0m"
GO111MODULE=on go get -v github.com/projectdiscovery/naabu/v2/cmd/naabu
echo -e "\e[1;31m done \e[0m"

#install httpx
echo -e "\e[1;31m installing httpx \e[0m"
GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx
echo -e "\e[1;31m done \e[0m"

#install ffuf
echo -e "\e[1;31m installing ffuf \e[0m"
go get -u github.com/ffuf/ffuf
echo -e "\e[1;31m done \e[0m"

#install wpscan
echo -e "\e[1;31m installing wpscan \e[0m"
git clone https://github.com/wpscanteam/wpscan.git
cd wpscan*
sudo gem install bundler && bundle install --without test
cd ~/tools/
echo -e "\e[1;31m done \e[0m"

echo -e "\e[1;34m Resourcing bash_profile \e[0m"
sleep 1
source ~/.bash_profile
sleep 2

echo -e "\n\n\n\n\n\n\n\n\n\n\n\e[1;31m Done! All tools are set up in ~/tools \e[0m"
ls -la
echo -e "\e[1;36m One last time: don't forget to set up AWS credentials in ~/.aws/! \e[0m"
