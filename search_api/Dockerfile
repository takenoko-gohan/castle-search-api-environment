FROM golang:1.13.15-alpine3.12

RUN mkdir -p /app/src

WORKDIR /app/src

RUN apk add --no-cache \
        alpine-sdk \
        git && \
    git clone https://github.com/takenoko-gohan/castle-search-api.git && \
    cd castle-search-api && \
    go build -o /app/search_api cmd/castle_search/main.go

CMD ["/app/search_api"]
