FROM node:12

ARG APP_DIR=app
RUN mkdir -p ${APP_DIR}
WORKDIR ${APP_DIR}
COPY . .
RUN npm install

EXPOSE 5000

CMD ["npm", "start"]
