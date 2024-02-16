FROM golang:1.17-buster AS build

WORKDIR /app

COPY go.mid ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /github-actions-aws-acr

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /github-actions-aws-acr /github-actions-aws-acr

USER nonroot:nonroot

ENTRYPOINT [ "/github-actions-aws-acr" ]
