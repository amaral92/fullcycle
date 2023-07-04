FROM golang:1.21rc2-alpine3.18 as builder

WORKDIR /usr/app/go

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags="-w -s" fullcycle-rocks.go

FROM scratch

WORKDIR /usr/app

COPY --from=builder /usr/app/go /usr/app/go

ENTRYPOINT ["go/fullcycle-rocks"]
