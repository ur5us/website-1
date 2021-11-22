FROM crystallang/crystal:1.2.2
WORKDIR /app
ARG GITHUB_TOKEN
COPY . .
RUN git config --global url."https://${GITHUB_TOKEN}@github.com".insteadOf "https://github.com"

ENV MARTEN_ENV=production

RUN apt-get update
RUN apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

RUN npm install
RUN npm rebuild node-sass
RUN npm run gulp -- build --production

RUN shards install
RUN bin/marten collectassets --no-input
RUN crystal build src/server.cr -o bin/website

CMD ["/app/bin/website"]