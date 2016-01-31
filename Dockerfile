FROM ruby:2.0

RUN apt-get update
RUN apt-get install -y nginx

RUN	ruby -S gem install jekyll

ADD . /tmp

WORKDIR /tmp

# build
RUN jekyll build

WORKDIR /data/www
RUN /bin/cp -R /tmp/_site/* /data/www

RUN rm -v /etc/nginx/nginx.conf

ADD nginx.conf /etc/nginx/
EXPOSE 80

CMD service nginx start