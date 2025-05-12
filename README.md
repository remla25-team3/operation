# operation

## Services

* app-frontend: [v1.1.0](https://github.com/remla25-team3/app-frontend/releases/tag/v1.1.0)
* app-service: [v1.1.0](https://github.com/remla25-team3/app-service/releases/tag/v1.1.0)
* lib-ml: [v0.1.0](https://github.com/remla25-team3/lib-ml/releases/tag/v0.1.0)
* lib-version: [v1.2.0](https://github.com/remla25-team3/lib-version/releases/tag/v1.2.0)
* model-service: [v0.1.0](https://github.com/remla25-team3/model-service/releases/tag/v0.1.0)
* model-training: [main](https://github.com/remla25-team3/model-training/tree/refs/heads/main)
* operation: [this repo](https://github.com/remla25-team3/operation)

## Information 

* Run project by cd ing to xxx/operation and running docker compose up
* Once running, API documentation available on http://localhost:8082/apidocs/ for `app-service` and http://localhost:8081/apidocs/ for `model-service`.

## Assignment 2

As of 12 May 2025, Assignment 2 has been implemented up to step 16.
The rest is to follow soon.

## Assignment 1

### Rubric

The following parts of the rubric were, to the best of our judgment, implemented in the code.

* Data availability: document follows structure outlined by template
* Use case: front end currently unable to display predictions
* Automated release process: lib-ml and lib-version currently using release-please. Other repositories still rely on Git Tags to be created
* Software Reuse in Libraries: not currently being used.
* Exposing a Model via REST: code is set up for all services to communicate with each other through REST where necessary, for which Flask is employed. The communication itself does not work as of yet because the docker-compose is not completely done. The setup to configure `model-service` DNS name and ports through ENV variables is there (but unused because the communication is not done yet).
* Docker Compose Operation: docker compose uses volume mapping, port mapping and an environment variable.


