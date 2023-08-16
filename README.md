# bootstrap-otel-auth-app

**NOTE (08.10.23)**: This is an active WIP and doesn't work yet; I will remove this when basic functionality has been completed.

A repo that demonstrates setting up an app with Authentication / Authorization (AuthN/Z) and an OTEL exporter for important observability data to be consumed by Prometheus, Loki, Jaeger, et. al., visualized on a set of Grafana dashboards.

# Getting Started

Run `make`

    This will build all of the docker images, create a KiND cluster, put the images onto the KiND cluster, apply (using Kustomize) all of the declarations to run and expose the containers.

Once the command is complete, browse to `http://app.localtest.me` to see the app.

# Cleaning Up

Run `make clean` to tear everything back down.
