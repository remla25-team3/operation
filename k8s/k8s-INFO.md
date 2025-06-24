# Understanding Kubernetes Ingress and the Ingress Controller

This document provides a technical deep-dive into how Kubernetes routes external traffic to internal services using two key components: the **Ingress Resource** and the **Ingress Controller**. It explains the role of each component and provides a step-by-step workflow based on this project's specific configuration.

## 1. Core Concepts: Ingress vs. Ingress Controller

To understand the workflow, it's essential to distinguish between these two related, but separate, components.

### The Ingress Resource

An Ingress is a Kubernetes API object that stores a collection of routing rules for external HTTP and HTTPS traffic. It is a declarative configuration object, meaning it only *describes* the desired state.

-   **Purpose**: To map URLs (hostnames and paths) to backend `Services` within the cluster.
-   **Functionality**: The Ingress resource itself has no power. It does not listen for traffic or route packets. It is simply a set of rules saved in the Kubernetes cluster's database.

### The Ingress Controller

An Ingress Controller is a running application within the Kubernetes cluster that actively manages network traffic.

-   **Its Role**: It is a reverse proxy (such as NGINX) running in one or more `Pods`.
-   **Its Function**: The controller's primary task is to watch the Kubernetes API for `Ingress` resources. When it detects an `Ingress` resource that it is responsible for, it translates those rules into its own native configuration and begins enforcing them.
-   **Implementation**: It is the operational component that actually implements the rules defined in an Ingress resource.

## 2. From Deployment to User Request

### Phase 1: Setup

-   **Controller Installation**: An NGINX Ingress Controller is assumed to be already running as a `Pod` in the cluster. This controller pod is exposed to the outside world, giving it a public IP address. This is the single entry point for all web traffic into the cluster.
-   **Deployment**: Run a command like `helm install my-app .` to deploy your application.
-   **Kubernetes Creates Resources**: Kubernetes processes your Helm chart's templates and creates all the necessary objects:
    -   `Deployments`, which create pods for `app-service`, `model-service`, etc.
    -   `Services`, which give those pods a stable internal IP address and DNS name.
    -   The two `Ingress` resources (`remla-app-ingress-main` and `remla-app-ingress-rewrite`) defined in `ingress.yaml` template.

### Phase 2: The Controller Acts

-   **Watching for Rules**: The NGINX Ingress Controller pod is programmed to constantly watch the Kubernetes API for any `Ingress` resources that have the `ingressClassName: nginx`.
-   **Reading Rules**: The controller sees two `Ingress` resources. It reads all the paths, backends, and annotations from both files.
-   **Dynamic Reconfiguration**: The controller takes all these rules and dynamically generates a new, complex `nginx.conf` file for itself inside its own pod.

### Phase 3: A User Makes a Request

The Ingress Controller is now configured and ready to route traffic from its public IP.

#### Request A: A user visits `http://<cluster-ip>/model/apidocs`

1.  The request from the user's browser hits the public IP address of the NGINX Ingress Controller.
2.  The controller's internal NGINX process receives the request. It checks its generated configuration file.
3.  It finds a rule for `path: /model/apidocs` with `pathType: Exact`. This is a perfect match.
4.  The rule tells it to proxy the request directly (with no changes) to the Kubernetes service named `model-service`.
5.  The request is forwarded to the `model-service`, which sends it to one of its pods, and the user sees the API documentation page.

#### Request B: A user sends a request to `http://<cluster-ip>/model/predict`

1.  The request hits the Ingress Controller's public IP.
2.  The controller checks its configuration. The path `/model/predict` does not match the documentation paths.
3.  It **does** match your special regex: `/model/(?!apidocs|flasgger_static|apispec_)(.*)`.
4.  This rule originates from the `remla-app-ingress-rewrite` resource, which has the `nginx.ingress.kubernetes.io/rewrite-target: /$2` annotation.
5.  The controller uses the regex to rewrite the path. The `(.*)` part of the regex captures `predict`. This is the second capture group (`$2`). Consequently, the request path `/model/predict` is rewritten to `/predict`.
6.  The controller proxies the **new, rewritten request for `/predict`** to the `model-service`.
7.  The `model-service` pod receives a request for `/predict`, which is exactly what its internal application code is expecting.

## Summary

In short, your `Ingress` YAML files are the **blueprint**, declaring how traffic *should* be routed. The **Ingress Controller** is the **engine** that reads that blueprint and actively performs the routing and rewriting of live traffic.