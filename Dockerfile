FROM golang:1.12.6 AS builder
WORKDIR /code
COPY ./ /code
RUN export GOPROXY=https://goproxy.io \
    && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Package
# Use scratch image
FROM scratch
WORKDIR /root/
COPY --from=builder /code/main /root/main
EXPOSE 8080
CMD ["/root/main"]
