FROM crystallang/crystal:1.6.2
WORKDIR /app
COPY . .

ENV MARTEN_ENV=production

RUN apt-get update
RUN apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs libsqlite3-dev

RUN npm install
RUN npm rebuild node-sass
RUN npm run gulp -- build --production

RUN shards install
RUN bin/marten collectassets --no-input
RUN scripts/build_docs
RUN crystal build src/server.cr -o bin/website --release

CMD ["/app/bin/website"]
