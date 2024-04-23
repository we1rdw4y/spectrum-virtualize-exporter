FROM quay.io/prometheus/golang-builder:main as builder
COPY . /app
RUN builder.sh -i github.ibm.com/ZaaS/spectrum-virtualize-exporter -p linux/amd64

FROM quay.io/prometheus/busybox:latest
COPY --from=builder spectrum-virtualize-exporter /bin/spectrum-virtualize-exporter
EXPOSE 9119
ENTRYPOINT ["/bin/spectrum-virtualize-exporter"]
CMD ["--config.file=/etc/spectrumVirtualize/spectrumVirtualize.yml"]
