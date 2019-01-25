#!/bin/bash
if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
fi

pushd $HOME

sudo apt install git

function install_zsh_and_ohmyzsh() {
	sudo apt install zsh

	if [ -d "$HOME/.oh-my-zsh/" ]; then
		printf "${RED}Found .oh-my-zsh in HOME directory.\nRemoving before reinstallation.${NORMAL}\n"
		printf "${YELLOW}Removing oh-my-zsh directory...\n"
		rm -rf $HOME/.oh-my-zsh
		printf "Removing .zshrc files in HOME directory...\n"
		ls -a $HOME | grep .zshrc | xargs rm
		printf "${NORMAL}"
	fi

	pushd /tmp
	curl -OfsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	sed -i "/env\ zsh\ -l/d" ./install.sh
	chmod u+x ./install.sh
	sh -c ./install.sh
	printf "${YELLOW}Cleaning up installation files.${NORMAL}"
	rm ./install.sh
	popd

}



#---------------install zsh and oh-my-zsh----------------
printf "${GREEN}${BOLD}"
echo -e "Install zsh and oh-my-zsh"
printf "${NORMAL}"
install_zsh_and_ohmyzsh
printf "${GREEN}${BOLD}DONE installing zsh and oh-my-zsh.${NORMAL}\n"
#-----------------------Done.----------------------------

printf "${GREEN}${BOLD}ALL installations jobs are Done.${NORMAL}"
printf "${NORMAL}"
popd
