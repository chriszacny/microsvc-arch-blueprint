# Makefile

CHECK_DOCKER := $(shell which docker || true)
CHECK_KIND := $(shell which kind || true)
CHECK_KUBECTL := $(shell which kubectl || true)

CLUSTER_NAME = bootstrap-otel-auth-app
CLUSTER_CONTEXT = kind-bootstrap-otel-auth-app
APP_IMAGE_NAME = bootstrap-otel-auth-app/app

KUBECONFIG = $(PWD)/kubeconfig
K9S = k9s --kubeconfig=$(KUBECONFIG)
KUBECTL = kubectl --kubeconfig=$(KUBECONFIG)

# Default target
all: check_prereqs
	$(shell deploy/create-cluster.sh $(CLUSTER_NAME) $(KUBECONFIG))
	$(KUBECTL) config set-context $(CLUSTER_CONTEXT)
	$(KUBECTL) cluster-info --context $(CLUSTER_CONTEXT)
	cd ./app && docker build -t $(APP_IMAGE_NAME) .
	kind load docker-image $(APP_IMAGE_NAME) --name $(CLUSTER_NAME)
	$(KUBECTL) --context $(CLUSTER_CONTEXT) apply -k deploy/
	echo "Check status of nginx ingress controller pods via: kubectl get pods --namespace=nginx-ingress"

check_prereqs:
	@if [ -z "$(CHECK_DOCKER)" ]; then \
        echo "Binary 'docker' is not installed on your system. Please install docker to proceed."; \
		exit 1;\
    else \
        echo "Binary 'docker' is installed."; \
    fi

	@if [ -z "$(CHECK_KIND)" ]; then \
        echo "Binary 'kind' is not installed on your system. Please install kind to proceed."; \
		exit 1;\
    else \
        echo "Binary 'kind' is installed."; \
    fi

	@if [ -z "$(CHECK_KUBECTL)" ]; then \
        echo "Binary 'kubectl' is not installed on your system. Please install kubectl to proceed."; \
		exit 1;\
    else \
        echo "Binary 'kubectl' is installed."; \
    fi

k9s:
	$(K9S)

clean:
	$(shell deploy/delete-cluster.sh $(CLUSTER_NAME))
	rm $(PWD)/kubeconfig

.PHONY: all clean check_prereqs
