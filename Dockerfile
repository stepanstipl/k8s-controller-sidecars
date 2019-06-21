FROM golang:1.12-alpine AS builder
RUN go version

ENV REPO=https://github.com/nrmitchi/k8s-controller-sidecars

COPY . /go/src/github.com/nrmitchi/k8s-controller-sidecars
WORKDIR /go/src/github.com/nrmitchi/k8s-controller-sidecars
RUN set -x && \
    apk add --update --no-cache \
      git && \
    go get github.com/golang/dep/cmd/dep && \
    dep ensure -v

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o /k8s-controller-sidecars .

FROM scratch
# ADD ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /k8s-controller-sidecars /
CMD ["/k8s-controller-sidecars"]
