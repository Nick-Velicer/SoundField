FROM node:17-alpine

WORKDIR /app

# install dependencies
COPY package.json .
COPY package-lock.json .
RUN npm install

# add app
COPY . .

EXPOSE 3000

CMD ["npm", "start"]