#Multi Stage Build
FROM node:18 AS build

WORKDIR /usr/app

COPY package*.json /usr/app/

RUN npm install

COPY . .

#Deploy Stage
FROM node:18-alpine3.20 AS deploy

WORKDIR /usr/app

COPY --from=build /usr/app .

ENV MONGO_URI='mongodb+srv://supercluster.d83jj.mongodb.net/superData'

ENV MONGO_USERNAME='superuser'

ENV MONGO_PASSWORD='SuperPassword'

EXPOSE 3000

CMD [ "npm", "start" ]