FROM node:18 AS test_builder

# Create app directory
WORKDIR /app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./
COPY prisma ./prisma/

# Install app dependencies
RUN yarn install

COPY . .

RUN rm -rf dist

RUN yarn run build

RUN npx prisma migrate deploy

RUN apt-get update && \
    apt-get install -y openjdk-11-jdk ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/

RUN export JAVA_HOME

COPY . .

RUN wget https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.4.3.tgz

RUN tar -xvf apache-jmeter-5.4.3.tgz

RUN chmod a+x ./apache-jmeter-5.4.3/bin/jmeter

RUN yarn run start:prod &

EXPOSE 3000

RUN ./apache-jmeter-5.4.3/bin/jmeter -n -t warehouse-test.jmx -l jmeter_log.log -e -f -o reports/

# FROM scratch AS export-stage
#
# CMD bash
