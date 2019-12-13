FROM node

RUN apt-get update && apt-get install -y curl locales
RUN curl https://install.meteor.com/ | sh

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /home/node/app
COPY . .
RUN npm install
RUN meteor npm install
RUN chown -R node .meteor
RUN chmod 755 /var/log

USER node

EXPOSE 3000

CMD npm start
