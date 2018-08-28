FROM alpine:3.8

ENV KUBECTL_VERSION="v1.10.0"

RUN apk add --update ca-certificates curl bash \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && rm /var/cache/apk/*

WORKDIR /opt

COPY . /opt

CMD ["bash", "port-forward.sh"]
