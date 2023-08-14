# bootstrap-otel-auth-app

**NOTE (08.10.23)**: This is an active WIP and doesn't work yet; I will remove this when basic functionality has been completed.

A repo that demonstrates setting up an app with authentication / authorization (authn/z) and an OTEL exporter for important observability data to be consumed by Prometheus, Loki, Jaeger, et. al., visualized on a set of Grafana dashboards.

# Getting Started

Run `make`

    This will build all of the docker images, create a KiND cluster, put the images onto the KiND cluster, apply (using Kustomize) all of the declarations to run and expose the containers.

After make is complete, you will need to:

    kubectl --kubeconfig ./kubeconfig --context kind-bootstrap-otel-auth-app get nodes -o=wide
    kubectl --kubeconfig ./kubeconfig --context kind-bootstrap-otel-auth-app -n nginx-ingress describe svc

- Save the above output
- Modify /etc/hosts to look like this:

        <IP_ADDRESS> testapp

- Where `<IP_ADDRESS>` is the IP Address from the get nodes command above. In my case it is 172.19.0.2, so my /etc/hosts looks like:

        172.19.0.2 testapp

- Modify the ingress with the DNS name testapp for the host (this should already be in the repo)
- Now, use a browser to go to `http://testapp:<PORT>/app` where `<PORT>` is the port from the describe svc command above.
- I plan to automate all of this shortly.

# Cleaning Up

Run `make clean` to tear everything back down.
