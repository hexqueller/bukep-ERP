FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod main.go ./

RUN go mod download && CGO_ENABLED=0 GOOS=linux go build -o server main.go

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/server .

RUN chmod +x /app/server

EXPOSE 8080
CMD ["/app/server"]