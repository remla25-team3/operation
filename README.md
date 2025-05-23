# operation

## Services

* app-frontend: [v1.2.0](https://github.com/remla25-team3/app-frontend/releases/tag/v1.2.0)
* app-service: [v1.2.0](https://github.com/remla25-team3/app-service/releases/tag/v1.2.0)
* lib-ml: [v0.1.0](https://github.com/remla25-team3/lib-ml/releases/tag/v0.1.0)
* lib-version: [v1.2.0](https://github.com/remla25-team3/lib-version/releases/tag/v1.2.0)
* model-service: [v0.2.0](https://github.com/remla25-team3/model-service/releases/tag/v0.2.0)
* model-training: [v1.1.0](https://github.com/remla25-team3/model-training/releases/tag/v1.1.0)
* operation: [this repo](https://github.com/remla25-team3/operation)

## Assignment 3

##### Prerequisites
- **Minikube** installed and configured
- **kubectl**

##### Running the application in a kubernetes cluster

_Please note:_ there is currently an issue in the setup of the `app-service` pod, causing requests from the frontend to fail. The below steps can still be followed to set up pods for the `app-frontend` and `model-service` services. Any code related to the kubernetes setup is located in the folder `operation/kubernetes`.

1. Run `minikube start`
2. Navigate to `operation/kubernetes`
3. Run `kubectl apply -f appfrontend.yml`, `kubectl apply -f appservice.yml`, `kubectl apply -f modelservice.yml`
4. Open a tunnel: `minikube tunnel`
5. You can access the frontend by navigating to http://localhost:80

## Assignment 2

##### Prerequisites
- **Vagrant** & **VirtualBox** installed  
- **Ansible** on host machine
- OS user must be able to edit `/etc/hosts`
- To use SSH access, your **SSH public key** (e.g., `~/.ssh/<your_key>.pub`) must be copied to:

```plaintext
<repo-dir>/provisioning/public_keys/
```

##### Clone & Start
```bash
git clone <repo-url>
vagrant up
ansible-playbook -u vagrant -i 192.168.56.100, provisioning/finalization.yml --ask-vault-pass
````
and type the password `1234` when prompted.

Then follow the instructions printed in the last message (repeated here):

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
vagrant ssh ctrl
kubectl -n kubernetes-dashboard create token admin-user
```
##### 6. Paste the token into the Dashboard login screen.
##### 7. Exit the Controller VM
Once you have retrieved the token, you can exit the controller VM by pressing Ctrl + D

##### 8. Free Disk Space
To remove the virtual machines and free up disk space when you're done, run the following command from the provisioning directory on your host machine:
```bash
vagrant destroy -f
```
This will forcefully stop and delete all Vagrant-managed virtual machines related to this project.

## Assignment 1

### Information 

* Run project by cd ing to xxx/operation and running docker compose up
* Once running, API documentation available on http://localhost:8082/apidocs/ for `app-service` and http://localhost:8081/apidocs/ for `model-service`.

### Rubric

The following parts of the rubric were, to the best of our judgment, implemented in the code.

* Data availability: document follows structure outlined by template
* Use case: front end currently unable to display predictions
* Automated release process: lib-ml and lib-version currently using release-please. Other repositories still rely on Git Tags to be created
* Software Reuse in Libraries: not currently being used.
* Exposing a Model via REST: code is set up for all services to communicate with each other through REST where necessary, for which Flask is employed. The communication itself does not work as of yet because the docker-compose is not completely done. The setup to configure `model-service` DNS name and ports through ENV variables is there (but unused because the communication is not done yet).
* Docker Compose Operation: docker compose uses volume mapping, port mapping and an environment variable.


