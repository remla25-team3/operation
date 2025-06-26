# Rubrics Compliance

For clarity and to assist in the grading process, we have compiled the following list of rubric items from the assignment description. Each checked item indicates a requirement that we believe we have addressed in our project. This is intended as a guide to demonstrate our understanding of the requirements and to facilitate the review process.

---

## Assignment 1: Versions, Releases, and Containerization

### Basic Requirements

#### Data Availability

- ✅ **Pass:** The structure of the GitHub organization follows the requested template and all relevant information is accessible. The operation repository contains a README.md file the provides all necessary information to find and start the application. 

#### Sensible Use Case

- ✅ **Pass:** The application has a frontend that allows to query the model and includes additional interactions which can be leveraged for continuous experimentation. An operator can give feedback to say if the prediction was right or wrong. 

### Versioning & Releases

#### Automated Release Process

- ✅ **Sufficient:**
    - ✅ All artifacts of the project are versioned and shared in package registries. 
    - ✅ The packaging and releases of all artifacts are performed in workflows. 
- ✅ **Good:**
    - ✅ Release workflows automatically version all artifacts through using a Git release tag like v1.2.3. 
    - ✅ After a stable release, main is set to a pre-release version that is higher than the latest release. 
- ✅ **Excellent:**
    - ✅ The released container images support multiple architectures, at least amd64 and arm64. 
    - ✅ The Dockerfile uses multiple stages, e.g., to reduce image size by avoiding apt cache in image. 
    - ✅ The automation supports to release multiple versions of the same pre-release, like 1.2.3-pre-<n>
          NOTE: Our prerelease is in format 1.2.3-canary.n


#### Software Reuse in Libraries

- ✅ **Sufficient:**
    - ✅ Both lib-version and lib-ml are reused in the other components as external dependencies, i.e.. they are not being referred to locally, but included via regular package managers. 
- ✅ **Good:**
    - ✅ The lib-ml has meaningful data structures or logic used by training and model service. 
    - ✅ The model-service pre-processes queries the same as the training pipeline does. 
    - ✅ The version string in lib-version is automatically updated with the actual package version in the release workflow, i.e., either it is directly taken from automatically updated project metadata, or it is taken from an automatically generated file. 
- ✅ **Excellent:**
    - ✅ The model is not part of the container image, i.e., it can be updated without creating a new image by refering to a specific model version that is downloaded on-start. 
    - ✅ A local cache is used so the model is not just downloaded on every container start. 

### Containers & Orchestration

#### Exposing a Model via REST
 
- ✅ **Sufficient:**
    - ✅ Flask is used to serve the model, all deployed components communicate through REST. 
- ✅ **Good:**
    - ✅ An ENV variable defines the DNS name and port of the model-service. 
    - ✅ All server endpoints have a well-defined API definition that follows the Open API Specification, and documents at least a summary, the parameters, and the response. 
- ✅ **Excellent:**
    - ✅ The listening port of the model-service can be configured through an ENV variable 

#### Docker Compose Operation

- ✅ **Sufficient:**
    - ✅ The operation repository contains a docker-compose.yml file that allows to start up the application and use it. 
    - ✅ The app-service is the only service that is accessible from the host. 
- ✅ **Good:**
    - ✅ The Docker compose file uses a volume mapping, a port mapping, and an environment variable. 
    - ✅ The compose file works with the same images as the final Kubernetes deployment does. 
    - ✅ Services have a restart policy (i.e., unless-stopped)
- ✅ **Excellent:**
    - ✅ The deployment contains an example of a Docker secret. 
    - ✅ The deployment uses an environment file, e.g., to configure names/versions of images. 

---

## Assignment 2: Provisioning a Kubernetes Cluster

### Provisioning

#### Setting up (Virtual) Infrastructure

- ✅ **Sufficient:**
    - ✅ All expected VMs exist, can be booted and have correct hostnames. 
    - ✅ All VM are attached to a private network and can directly communicate with all other VMs. 
    - ✅ All VMs are directly reachable from the host through a host-only network, i.e., without port-forward. 
    - ✅ The VMs are provisioned with Ansible and the provisioning finishes within a maximum of 5 minutes (might take a bit longer)
- ✅ **Good:**
    - ✅ The Vagrantfile uses a loop and template arithmetic when defining node names or IPs. 
    - ✅ Used CPU cores, memory size, and number of provisioned worker nodes are controlled via variables. 
- ✅ **Excellent:**
    - ✅ Extra arguments are passed from Vagrant to Ansible (i.e., number of workers) 
    - ✅ Vagrant generates a valid inventory.cfg for Ansible that contains all (and only) the active nodes. 

#### Setting up Software Environment

- ✅ **Sufficient:**
    - ✅ At least on automation installs a package with apt. 
    - ✅ At least on automation starts a service and registers it for auto-start. 
    - ✅ At least on automation copies a file into the VM. 
    - ✅ At least on automation edits a configuration inside the VM. 
- ✅ **Good:**
    - ✅ The playbook uses several built-in modules to achieve an idempotent provisioning. 
    - ✅ The playbook registers variables to share values between different tasks. 
    - ✅ At least one automation contains a loop, e.g., when copying multiple SSH keys 
    - ✅ Cluster does not get re-initialized when rerunning the provisioning. 
- ✅ **Excellent:**
    - ✅ The Ansible playbook generates a correct /etc/hosts, so all VMs are reachable by name. 
    - ✅ The file contains all (but only existing) workers, so information must be passed from Vagrant to Ansible. 
    - ✅ Ansible contains at least one example of a waiting step to prevent errors in steps that depend on the completion of slow Kubernetes deployments 
    - ✅ The playbook contains a regexp-based replacement in a configuration file. 
    - ✅ The replacement is idempotent, i.e., the file does not change anymore for repeated executions. 

#### Setting up Kubernetes

- ✅ **Sufficient:**
    - ✅ A working kubectl configuration is generated or copied to the host folder during provisioning. 
    - ✅ A host-based kubectl can communicate with the control plane and apply/delete resources. 
    - ✅ The vagrant user has a working kubectl configuration on the controller node. 
    - ✅ The in-class exercises of the Kubernetes and Istio lectures can be deployed and are functional. 
- ✅ **Good:**
    - ✅ Cluster has a proxy (e.g., metallb) that can provide IPs to Load Balancer services. 
    - ✅ Cluster has a working HTTP Ingress Controller (e.g., Nginx). 
    - ✅ Cluster has a working Istio Gateway. 
- ✅ **Excellent:**
    - ✅ The Kubernetes Dashboard is directly reachable without opening a tunnel. 
    - ✅ Ingress Controller has fixed IP. 
    - ✅ Istio Gateway has fixed IP. 
    - ✅ Cluster has an HTTPS Ingress Controller (e.g., Nginx) with self-signed certificates. 

---

## Assignment 3: Operate and Monitor Kubernetes

### Kubernetes & Monitoring

#### Kubernetes Usage

- ✅ **Sufficient:**
    - ✅ The application can be deployed to a Kubernetes cluster. 
    - ✅ The relevant deployment files contain at least a working Deployment and a working Service. 
    - ✅ The app is accessed through an Ingress and IngressController. 
- ✅ **Good:**
    - ✅ The deployed application defines the location of the model service through an environment variable. 
    - ✅ The model service can be relocated just by changing the Kubernetes config. 
    - ✅ The deployed application successfully uses a ConfigMap and a Secret. 
- ✅ **Excellent:**
    - ✅ All VMs mount the same shared VirtualBox folder as /mnt/shared into the VM. 
    - ✅ The deployed application mounts this path as a hostPath Volume into at least one Deployment. 

#### Helm Installation

- ✅ **Sufficient:**
    - ✅ A Helm chart exists that covers the complete deployment. 
- ✅ **Good:**
    - ✅ The chart has a values.xml and allows changing the (DNS) service name of the model service. 
- ✅ **Excellent:**
    - ✅ The Helm chart can be installed more than once into the same cluster. 

#### App Monitoring

- 🔴 **Poor:** The metrics are lacking an example for either Gauge or Counter. 
- 🔴 **Sufficient:**
    - 🔴 The app has 3+ app-specific metrics for reasoning about users behavior or model performance. 
    - 🔴 These metrics include a Gauge and a Counter. 
    - 🔴 The metrics are automatically discovered and collected by Prometheus, either through applying ServiceMonitor resources or later by adding appropriate labels to the deployments. 
- 🔴 **Good:**
    - 🔴 An app-specific Histogram metric is introduced. 
    - 🔴 Each metric types has at least one example, in which the metric is broken down with labels. 
- 🔴 **Excellent:**
    - 🔴 An AlertManager is configured with at least one non-trivial PrometheusRule. 
    - 🔴 A corresponding Alert is raised in any type of channel (e.g., via email). 
    - 🔴 The deployment files and the source code must not contain credentials (e.g., SMTP passwords). 

#### Grafana

- 🔴 **Poor:** A serious dashboard attempt exists, but it is incomplete or can only be imported with errors. 
- 🔴 **Sufficient:**
    - 🔴 A basic Grafana dashboard exists that illustrates all app-specific metrics. 
    - 🔴 The dashboard is defined in a JSON file and can be manually imported in the Web UI. 
    - 🔴 The operations repository contains a README.md that explains the manual installation (if required). 
- 🔴 **Good:**
    - 🔴 The dashboard contains specific visualizations for Gauges and Counters. 
    - 🔴 The dashboard employs variable timeframe selectors to parameterize the queries. 
    - 🔴 The dashboard applies functions (like rate or avg) to enhance the plots. 
- 🔴 **Excellent:**
    - 🔴 The Grafana dashboard is automatically installed, e.g., through a ConfigMap. 

---

## Assignment 4: ML Configuration Management & ML Testing

### ML Testing

#### Automated Tests

- ✅ **Sufficient:**
    - ✅ Tests follow the ML Test Score methodology to measure test adequacy. 
    - ✅ Each category has at least one test: Feature and Data; Model Development; ML infrastructure; Monitoring tests. 
    - ✅ It is clear which tests belong to which category. 
- ✅ **Good:**
    - ✅ Test for non-determinism robustness exist and use data slices to test model capabilities. 
    - ✅ Non-functional requirements such as memory and performance are being tested. 
    - ✅ The cost of features is being tested. 
- ✅ **Excellent:**
    - ✅ Test adequacy is measured and reported on the terminal when running the tests. 
    - ✅ Test coverage is automatically measured, for example, with+coverage.py. 
    - ✅ There is an implementation of mutamorphic testing with automatic inconsistency repair. 

#### Continuous Training

- ✅ **Sufficient:**
    - ✅ The execution of tests and linter are included in a GitHub workflow. 
    - ✅ pytest automatically runs all tests on every push. 
    - ✅ pylint automatically runs on every push. 
- ✅ **Good:**
    - ✅ Test adequacy metrics (e.g., ML Test Score) are calculated during the workflow execution. 
    - ✅ Test coverage is measured during workflow execution. 
- ✅ **Excellent:**
    - ✅ The test adequacy score is added and automatically updated in the README. 
    - ✅ The test coverage is added and automatically updated in the README. 
    - ✅ The pylint score is added and automatically updated in the README. 

### ML Configuration Management

#### Project Organization

- ✅ **Sufficient:**
    - ✅ The project is converted into a Python project. 
    - ✅ The pipeline stages for training, data prep, and evaluation are clearly separated into scripts. 
    - ✅ Dependencies are formally declared for a package manager, e.g., in a requirements.txt file. 
    - ✅ The project layout is at least inpired by the Cookiecutter template. 
- ✅ **Good:**
    - ✅ The dataset is not stored in the repository, it gets automatically downloaded in the pipeline. 
    - ✅ Exploratory code is kept separate from production code. 
    - ✅ The Python project is reduced to the required source code. 
- ✅ **Excellent:**
    - ✅ The model is packaged and automatically published as a versioned GitHub release. 

#### Pipeline Management with DVC

- ✅ **Sufficient:**
    - ✅ All the different stages of the pipeline can be run using dvc repro. 
    - ✅ All relevant dependencies and outputs are defined. 
    - ✅ The pipeline is fully reproducible via dvc repro. 
    - ✅ The pipeline uses any kind of remote storage. 
- ✅ **Good:**
    - ✅ The pipeline uses cloud-based remote storage (i.e., Google Drive). 
    - ✅ The pipeline can be rolled back to past versions. 
    - ✅ An accuracy-related metrics is generated in one of stages and stored in a JSON output file. 
- ✅ **Excellent:**
    - ✅ The generated metric file is registered as a metric in one of the pipeline stages. 
    - ✅ Running dvc exp show allows exploring the results of different experiments/models. 
    - ✅ Different metrics are reported that go beyond model accuracy. 

#### Code Quality

- ✅ **Sufficient:**
    - ✅ The project contains a valid, non-standard pylint configuration. 
    - ✅ Running pylint does not show any warnings for the project. 
- ✅ **Good:**
    - ✅ The project applies multiple linters (e.g., flake8, Bandit) with non-default configurations. 
- ✅ **Excellent:**
    - ✅ The project implements at least one custom pylint rule that catches ML-Specific Code Smells (i.e., Randomness Uncontrolled).

---

## Assignment 5: Istio Service Mesh

### Implementation

#### Traffic Management

- ✅ **Sufficient:**
    - ✅ The project resembles the state of the in-class exercise.
    - ✅ The app defines a Gateway and VirtualServices.
    - ✅ The application is accessible through the IngressGateway (i.e., minikube tunnel).
- ✅ **Good:**
    - ✅ It uses Destination Rules and weights to enable a $90/10$ routing of the app service.
    - ✅ The versions of model-service and app are consistent (it also shows "canary release" in the frontend)
- ✅ **Excellent:**
    - 🔴 The project implements Sticky Sessions, i.e., requests from the same origin have a stable routing.

#### Additional Use Case

- ✅ **Excellent:**
    - ✅ One of the described use cases has been fully realized. (Global+local rate limiting)

#### Continuous Experimentation

- ✅ **Sufficient:**
    - ✅ The documentation describes the experiment. It explains the implemented changes, the expected effect that gets experimented on, and the relevant metric that is tailored to the experiment.
    - ✅ The experiment involves two deployed versions of at least one container image.
    - ✅ Both component versions are reachable through the deployed experiment.
    - ✅ The system implements the metric that allows exploring the concrete hypothesis.
- 🔴 **Good:**
    - ✅ Prometheus picks up the metric.
    - ✅ Grafana has a dashboard to visualize the differences and support the decision process.
    - ✅ The documentation contains a screenshot of the visualization.
- ✅ **Excellent:**
    - ✅ The documentation explains the decision process for accepting or rejecting the experiment in details, ie.g., which criteria is used and how the available dashboard supports the decision.

### Documentation

#### Deployment Documentation

- ✅ **Sufficient:**
    - ✅ The documentation describes the deployment structure, i.e., the entities and their connections.
    - ✅ The documentation describes the data flow for incoming requests.Also indicate at which points dynamic routing decisions are taken (e.g., 90/10-split).
    - ✅ The documentation contains visualizations that are connected to the text.
- ✅ **Good:**
    - ✅ The documentation includes all deployed resource types and relations.
- ✅ **Excellent:**
    - ✅ The documentation is visually appealing and clear.
    - ✅ A new team member could contribute in a design discussion after studying the documentation.

#### Extension Proposal

- ✅ **Sufficient:**
    - ✅ The documentation describes one release-engineering-related shortcoming of the project practices.
    - ✅ A proposed extension addresses the shortcoming and is connected to one of the assignments.
    - ✅ The extension is genuine and has not already been mentioned in any of the assignment rubrics.
    - ✅ The documentation cites external sources that inspired the envisioned extension.
- ✅ **Good:**
    - ✅ The shortcoming is critically reflected on and its negative effects get elaborated in detail.
    - ✅ The presented extension improves the described shortcoming.
    - ✅ The documentation explains how an improvement could be measured objectively in an experiment.
- ✅ **Excellent:**
    - ✅ The presented extension is general in nature and applicable beyond the concrete project.
    - ✅ The presented extension clearly overcomes the described shortcoming.
