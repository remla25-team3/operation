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

##### Prerequisites
- **Vagrant** & **VirtualBox** installed  
- **Ansible** on host machine
- OS user must be able to edit `/etc/hosts`

##### Clone & Start
```bash
git clone <repo-url> && cd <repo-dir>/provisioning
vagrant up --provision
ansible-playbook -u vagrant -i 192.168.56.100, finalization.yml
````
and follow the instructions printed in the last message (repeated here):

##### 1. Open your terminal on the host machine and run:
```bash
sudo nano /etc/hosts
```
##### 2. Add the following line to the bottom of the file:
```bash
192.168.56.91   dashboard.local
```
##### 3. Save and exit nano:
    Press Ctrl + O (to write the file), then Enter, then Ctrl + X (to exit)
##### 4. Open your browser and visit: https://dashboard.local
##### 5. To log in, run the following command on the controller VM to generate a token:
```bash
kubectl -n kubernetes-dashboard create token admin-user
```
##### 6. Paste the token into the Dashboard login screen.


## Assignment 1

### Rubric

The following parts of the rubric were, to the best of our judgment, implemented in the code.

* Data availability: document follows structure outlined by template
* Use case: front end currently unable to display predictions
* Automated release process: lib-ml and lib-version currently using release-please. Other repositories still rely on Git Tags to be created
* Software Reuse in Libraries: not currently being used.
* Exposing a Model via REST: code is set up for all services to communicate with each other through REST where necessary, for which Flask is employed. The communication itself does not work as of yet because the docker-compose is not completely done. The setup to configure `model-service` DNS name and ports through ENV variables is there (but unused because the communication is not done yet).
* Docker Compose Operation: docker compose uses volume mapping, port mapping and an environment variable.


