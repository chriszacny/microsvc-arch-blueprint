# bootstrap-otel-auth-app

**NOTE (08.10.23)**: This is an active WIP and doesn't work yet; I will remove this when basic functionality has been completed.

A repo that demonstrates setting up an app with Authentication / Authorization (AuthN/Z) and an OTEL exporter for important observability data to be consumed by Prometheus, Loki, Jaeger, et. al., visualized on a set of Grafana dashboards.

# Getting Started

Run `make`

    This will build all of the docker images, create a KiND cluster, put the images onto the KiND cluster, apply (using Kustomize) all of the declarations to run and expose the containers.

Once the command is complete, browse to `http://app.localtest.me` to see the app.

# Cleaning Up

Run `make clean` to tear everything back down.

# In Depth Explanations / How the "Dark Magic" Works

## Getting NGINX Inc. Ingress to work in KiND

The KiND documentation (as of 8.16.23), uses "ingress-nginx" which is the OSS fork of the NGINX Ingress Controller.

This repo uses the "official" NGINX Inc. code/repo which is beneficial due to the additional security modules that are available in addition to compatibility with NGINX Plus, etc.

To get it to work, there were a few things I had to do:

- Make sure to set `extraPortMappings` per `https://kind.sigs.k8s.io/docs/user/configuration/#extra-port-mappings`. I set the listenAddress to `0.0.0.0` just to be explcit.
- In the NGINX Ingress Deployment `./nginx-ingress/base/nginx-ingress.yaml`, make sure to set the `hostPort` in the mapped ports, like so:

        .
        .
        .
        containers:
        - image: nginx/nginx-ingress:3.2.0
          imagePullPolicy: IfNotPresent
          name: nginx-ingress
          ports:
            - name: http
              containerPort: 80
              hostPort: 80
            - name: https
              containerPort: 443
              hostPort: 443
        .
        .
        .

- It isn't clear to me whether the NodePort is even needed in this case; it is commented out in the kustomization file for now. When deploying to a Cloud Provider with a Load Balancer, this would likely look a bit different given the Ingress will likely be a DaemonSet.
