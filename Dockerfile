# Build stage
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /ms-saudacoes-aleatorias

# Final stage
FROM alpine:latest
WORKDIR /
COPY --from=builder /ms-saudacoes-aleatorias /ms-saudacoes-aleatorias
EXPOSE 8080
ENTRYPOINT ["/ms-saudacoes-aleatorias"]