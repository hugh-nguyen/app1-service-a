FROM node:18-slim
WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

COPY package.json package-lock.json tsconfig.json ./
COPY src/ ./src

RUN npm install -g typescript

RUN npm install

RUN npm run build

EXPOSE 80
CMD ["npm", "start"]
