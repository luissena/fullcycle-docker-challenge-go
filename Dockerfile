FROM golang:alpine AS builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "-s -w" -a -installsuffix cgo -o main main.go

FROM scratch AS runner

COPY --from=builder /app/main /main

ENTRYPOINT ["/main"]