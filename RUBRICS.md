# Rubrics Compliance

For clarity and to assist in the grading process, we have compiled the following list of rubric items from the assignment description. Each checked item indicates a requirement that we believe we have addressed in our project. This is intended as a guide to demonstrate our understanding of the requirements and to facilitate the review process.

## Assignment 1

### Data Availability

- ✅ **Pass:** The structure of the GitHub organization follows the requested template and all relevant information is accessible. The operation repository contains a README.md file the provides all necessary information to find and start the application.

### Sensible Use Case

- ✅ **Pass:** The application has a frontend that allows to query the model and includes additional interactions which can be leveraged for continuous experimentation. In our case, an operator can flag/change if a prediction was right or wrong.

### Versioning & Releases

#### Automated Release Process

- ✅ **Sufficient:** All artifacts of the project are versioned and shared in package registries. The packaging and releases of all artifacts are performed in workflows.
- ✅ **Good:** Release workflows automatically version all artifacts through using a Git release tag like v1.2.3. Automatic increase of Patch versions, bumps to minor or major versions can remain manual. After a stable release, main is set to a pre-release version that is higher than the latest release.
- ✅ **Excellent:** **The released container images support multiple architectures, at least amd64 and arm64???**. The Dockerfile uses multiple stages, e.g., to reduce image size by avoiding apt cache in image. The automation supports to release multiple versions of the same pre-release, like 1.2.3-pre-<n>, in which in is an automatically set counter or date. 

#### Software Reuse in Libraries

- ✅ **Sufficient:** Both lib-version and lib-ml are reused in the other components as external dependencies, i.e.. they are not being referred to locally, but included via regular package managers.
- ✅ **Good:** The lib-ml has meaningful data structures or logic used by training and model service. The model-service pre-processes queries the same as the training pipeline does. The version string in lib-version is automatically updated with the actual package version in the release workflow, i.e., either it is directly taken from an automatically generated file.
- ✅ **Excellent:** The model is not part of the container image, i.e., it can be updated without creating a new image by refering to a specific model version that is downloaded on-start. :odel URL is provided via environment variable. A local cache is used so the model is not just downloaded on every container start. For example, cache the model download in a mounted volume.

## Containers & Orchestration

### Exposing a Model via REST

- ✅ **Sufficient:** Flask is used to serve the model, all deployed components communicate through REST.
- ✅ **Good:** An ENV variable defines the DNS name and port of the model-service. All server endpoints have a well-defined API definition that follows the Open API Specification, and documents at least a summary, the parameters, and the response.
- ✅ **Excellent:** The listening port of the model-service can be configured through an ENV variable.

### Docker Compose Operation

- ✅ **Sufficient:** The operation repository contains a docker-compose.yml file that allows to start up the application and use it. The app-service is the only service that is accessible from the host.
- ✅ **Good:** The Docker compose file uses a volume mapping, a port mapping, and an environment variable. The compose file works with the same images as the final Kubernetes deployment does. Services have a restart policy (unless-stopped).
- ✅ **Excellent:** The deployment contains an example of a Docker secret. The deployment uses an environment file, e.g., to configure names/versions of images.