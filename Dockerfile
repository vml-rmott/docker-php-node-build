FROM debian:8.6

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive
ENV COMPOSER_NO_INTERACTION 1

# Add Node.js repo
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
 curl \
 apt-transport-https \
 ca-certificates \
 && curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
 && echo "deb https://deb.nodesource.com/node_0.12 jessie main" > /etc/apt/sources.list.d/nodesource.list \
# Install tools
 && apt-get update \
 && apt-get install --no-install-recommends -y \
 openssh-client \
 bzip2 \
 git \
 php5-cli \
 nodejs \
 && ln -f -s /usr/bin/nodejs /usr/bin/node \
 # Slim down image
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*

# Show versions
RUN php -v
RUN node -v
RUN npm -v

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer selfupdate

# Install node tools
RUN npm install -g gulp
RUN npm install -g npm-cache
RUN gulp --version
RUN npm-cache --version
