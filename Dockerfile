FROM node:8

WORKDIR /app

COPY package*.json ./
COPY ./src/index.js ./src/index.js

RUN npm install --only=production

EXPOSE 3000

CMD [ "npm", "start" ]
