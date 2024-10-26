FROM ubuntu:jammy
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get upgrade -y

ARG WITH_MAN=false
RUN if [ "$WITH_MAN" = "true" ]; then yes | unminimize && sudo apt-get install man; fi

RUN apt-get install -y software-properties-common build-essential curl
RUN add-apt-repository -y ppa:git-core/ppa
RUN apt-add-repository -y ppa:ansible/ansible
RUN apt-get update
RUN apt-get install -y git ansible
RUN apt-get clean autoclean
RUN apt-get autoremove --yes

RUN apt-get install sudo
RUN addgroup --gid 1000 awakefox
RUN adduser --gecos awakefox --gid 1000 --uid 1000 awakefox
RUN adduser awakefox sudo
RUN echo "awakefox ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV TERM=xterm-256color

USER awakefox
WORKDIR /home/awakefox

COPY . ./ansible
WORKDIR /home/awakefox/

ARG TAGS="--tags dotfiles,setup,shell,core,gitconfig_school_nopw,gp_config_nopw"
ENV ANS_TAGS=$TAGS
CMD ["sh", "-c", "if [ ! -f /home/awakefox/playbook_run_flag ]; then ansible-playbook $ANS_TAGS /home/awakefox/ansible/local.yml && touch /home/awakefox/playbook_run_flag; fi && tail -f /dev/null"]
