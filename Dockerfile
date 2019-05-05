FROM  ubuntu:latest
LABEL maintainer="marllon_mainardes"

# Atualiza o SO
RUN apt-get update && apt-get install -y openssh-server vim curl sudo htop tzdata
RUN apt-get update && apt-get install -y git
RUN sudo apt-get install -y build-essential automake autoconf \
    bison libssl-dev libyaml-dev libreadline6-dev \
    zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev \
    gawk g++ gcc make libc6-dev patch libsqlite3-dev sqlite3 \
    libtool pkg-config libpq-dev nodejs ruby-full

RUN sudo apt-get update && sudo apt-get install -y yarn

RUN mkdir /var/run/sshd

# Configura o SSH
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN echo 'Banner /etc/banner' >> /etc/ssh/sshd_config
COPY etc/banner /etc/

# Adciona o usuário 'app'
RUN useradd -ms /bin/bash app 
#RUN id -u app &>/dev/null || useradd -ms /bin/bash app 
RUN adduser app sudo
RUN echo 'app:app' |chpasswd

# Altera para o usuário 'app'
USER app

# Instala o NVM
RUN /bin/bash -l -c "gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB"
RUN /bin/bash -l -c "curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash"
RUN /bin/bash -l -c ". ~/.nvm/nvm.sh && nvm install node"



RUN /bin/bash -l -c "curl -L get.rvm.io | bash -s stable"

RUN /bin/bash -l -c "source /home/app/.rvm/scripts/rvm"
RUN /bin/bash -l -c "source ~/.rvm/scripts/rvm"
RUN /bin/bash -l -c "rvm requirements"

RUN /bin/bash -l -c "rvm install 2.5"
RUN /bin/bash -l -c "touch ~/.gemrc"
RUN /bin/bash -l -c "echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc"

#RUN /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
RUN /bin/bash -l -c "gem install rails -v 5.2.3"

# git config
RUN git config --global user.name "Marllon Mainardes"
RUN git config --global user.email mlmainardes@gmail.com
RUN git config --global core.editor emacs



# Altera para o usuário 'root'
USER root

# Expõe as portas
EXPOSE 22
EXPOSE 3000

# Cria e configura o ponto de montagem do volume
RUN mkdir -p /workspace
RUN chmod 777 /workspace
VOLUME /workspace

#roda quando o container sobe
CMD    ["/usr/sbin/sshd", "-D"]
