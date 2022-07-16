FROM node:18

WORKDIR /app

COPY package*.json ./
COPY prisma ./prisma/

RUN chmod +x ./prisma/wait-db.sh

RUN yarn install
RUN npx prisma generate

RUN apt update
RUN apt --assume-yes install postgresql-client

# Git will replace the LF line-endings with CRLF, causing issues while executing the wait-for-postgres shell script
# Install dos2unix and replace CRLF (\r\n) newlines with LF (\n)
RUN apt --assume-yes install dos2unix
RUN dos2unix ./prisma/wait-db.sh

CMD ./prisma/wait-db.sh postgres postgres npx prisma db push

# FROM justb4/jmeter

# RUN apt-get update && \
#     apt-get install -y openjdk-11-jdk ca-certificates-java && \
#     apt-get clean && \
#     update-ca-certificates -f
#
# ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
#
# RUN export JAVA_HOME
#
# COPY . .
#
# RUN wget https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.4.3.tgz
#
# RUN tar -xvf apache-jmeter-5.4.3.tgz
#
# RUN chmod a+x ./apache-jmeter-5.4.3/bin/jmeter
#
# RUN ./apache-jmeter-5.4.3/bin/jmeter -n -t warehouse-test.jmx -l jmeter_log.log -e -f -o reports/

# EXPOSE 3000
