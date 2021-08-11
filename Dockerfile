
FROM alpine:3.14 as k3s

RUN wget https://github.com/k3s-io/k3s/releases/download/v1.21.2%2Bk3s1/k3s -O /usr/local/bin/k3s \
    && \
    chmod +x /usr/local/bin/k3s

FROM scratch

COPY --from=k3s /usr/local/bin/k3s /k3s

EXPOSE 6443

ENTRYPOINT ["/k3s"]
CMD ["server", "--disable-agent", "--disable-cloud-controller", "-d", "/var/lib/rancher/k3s"]
