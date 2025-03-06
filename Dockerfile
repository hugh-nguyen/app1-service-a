FROM node:18
WORKDIR /app

COPY package.json yarn.lock tsconfig.json ./
COPY src/ ./src

RUN update-ca-certificates
ENV NODE_EXTRA_CA_CERTS=/usr/local/share/ca-certificates/ca.crt
RUN npm install -g typescript

RUN yarn
RUN yarn build

EXPOSE 5000
CMD ["npm", "start"]
