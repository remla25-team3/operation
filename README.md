# operation

* Run project by cd ing to xxx/operation and running docker compose up
* Once running api documentation available on http://localhost:8082/apidocs/ for app-service and http://localhost:8081/apidocs/ for model-service.

## Assignment 1

### Rubric

The following parts of the rubric were implemented in the code.

* Data availability: document follows structure outlined by template
* Use case: front end currently unable to display predictions
* Automated release process: lib-ml and lib-version currently using release-please. Other repositories still rely on Git Tags to be created
* Software Reuse in Libraries:
* Exposing a Model via REST:
* Docker Compose Operation: docker compose uses volume mapping, port mapping and an environment variable.

### Services

* app-frontend:
* app-service: [v1.0.0](https://github.com/remla25-team3/app-service/releases/tag/v1.0.0)
* lib-ml: [v0.1.0](https://github.com/remla25-team3/lib-ml/releases/tag/v0.1.0)
* lib-version: [v1.2.0](https://github.com/remla25-team3/lib-version/releases/tag/v1.2.0)
* model-service: [v1.0.0](https://github.com/remla25-team3/model-service/releases/tag/v1.0.0)
* model-training:
* operation: this repo
