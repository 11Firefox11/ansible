FROM ubuntu:jammy
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git software-properties-common curl build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

ARG TAGS="--tags shell"

RUN apt-get install sudo
RUN addgroup --gid 1000 awakefox
RUN adduser --gecos awakefox --gid 1000 --uid 1000 awakefox
RUN adduser awakefox sudo
RUN echo "awakefox ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV TERM xterm-256color

USER awakefox
WORKDIR /home/awakefox

COPY . ./ansible
WORKDIR /home/awakefox/

CMD ["sh", "-c", "if [ ! -f /home/awakefox/playbook_run_flag ]; then ansible-playbook $TAGS /home/awakefox/ansible/local.yml && touch /home/awakefox/playbook_run_flag; fi && tail -f /dev/null"]

