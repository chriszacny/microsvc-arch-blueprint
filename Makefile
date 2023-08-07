# Makefile

CHECK_DOCKER := $(shell which docker || true)
CHECK_KIND := $(shell which kind || true)
CHECK_KUBECTL := $(shell which kubectl || true)

CLUSTER_NAME = kind-bootstrap-otel-auth-app

# Directories
#SRCDIR = src
#BINDIR = bin

# Source files
#SOURCES = $(wildcard $(SRCDIR)/*.py)

# Binary name
#TARGET = $(BINDIR)/program

# Default target
all: check_prereqs
	kind create cluster --name $(CLUSTER_NAME)
	kubectl cluster-info --context $(CLUSTER_NAME)
# 	Ensure KiND is installed

#	docker build -t pythonapp .
#	docker run -ti --rm pythonapp

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

clean:
	kind delete cluster --name kind-bootstrap-otel-auth-app

.PHONY: all clean check_prereqs
