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

EXPOSE 3000

CMD yarn run start:prod

# RUN ./apache-jmeter-5.4.3/bin/jmeter -n -t warehouse-test.jmx -l jmeter_log.log -e -f -o reports/

# FROM scratch AS export-stage
#
# CMD bash
