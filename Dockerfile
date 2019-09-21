FROM golang:1.13.0-alpine3.10 as builder
LABEL maintainer="Geraldo Andrade <hi@geraldoandrade.com>"

WORKDIR /builder
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o money-go-api .


FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=builder /builder/money-go-api .

EXPOSE 8080
CMD ["./main"] 