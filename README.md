# operation

## Services

* app-frontend: [v1.3.2](https://github.com/remla25-team3/app-frontend/releases/tag/v1.3.2)
* app-service: [v1.3.1](https://github.com/remla25-team3/app-service/releases/tag/v1.3.1)
* lib-ml: [v0.5.0](https://github.com/remla25-team3/lib-ml/releases/tag/v0.5.0)
* lib-version: [v1.2.0](https://github.com/remla25-team3/lib-version/releases/tag/v1.2.0)
* model-service: [v0.3.4](https://github.com/remla25-team3/model-service/releases/tag/v0.3.4)
* model-training: [v0.2.3](https://github.com/remla25-team3/model-training/releases/tag/v0.2.3)
* operation: [this repo](https://github.com/remla25-team3/operation)

## Assignment 5

As of now, most parts of the assignment are *partially* implemented and work *to some extent*.
We are aware that updates are needed in the coming weeks to fulfill all requirements.

The application can still be started by e.g. following the instructions under *Assignment 2* below, but a problem that causes interaction between the `app-service` and `model-service` to fail has remained.

For A5, we particularly had trouble getting Istio to properly show our app (all pods run and Istio is set up, but we get a blank page when navigating to the gateway at a fixed IP), as well as getting rate limiting to work, which we will be addressing soon.

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
git clone git@github.com:remla25-team3/operation.git (using SSH)
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

## 🚀 Docker Compose Deployment

You can deploy the entire REMLA project with a single command. Our Docker Compose setup implements:

- **ENV configuration** via a `.env` file (e.g. `NGINX_PORT=8080`, `APP_PORT=3000`, `MODEL_PORT=5000`, and example Docker secret).
- **Port mappings** so only `app-frontend` is exposed on your host.
- **Volume mapping** for model caching.
- **Restart policies** (`restart: unless-stopped`) for all services.
- **Docker secret** example for sensitive data (`test_secret`).

### Start Up
From the root directory, run:
```bash
docker-compose up -d  # Bring up all services in detached mode
```
### Access the services:
- **Frontend UI**: http://localhost:8080/
- **App-service API Docs (Swagger)**: http://localhost:8080/app/apidocs
- **Model-service API Docs (Swagger)**: http://localhost:8080/model/apidocs

### Shut Down
```bash
docker-compose down
```


## Running on Kubernetes with Minikube
### ⚠️ Experimental - Work in Progress

Deployment and Testing Workflow

This workflow uses kubectl port-forward to provide temporary access to the application for testing.

1. Start Your Local Cluster

First, start your Minikube cluster
```bash
minikube start
```
minikube addons enable ingress

wait till controller is ready (few seconds)
kubectl get pods -n ingress-nginx


2. Install the Application

Navigate to the Helm chart directory (/k8s/remla-app/) and use Helm to install the application. We will name this deployment remla-demo.
```bash
# Navigate to the chart directory
cd path/to/your/remla-chart

# Install the chart
helm install remla-app .
```

3. Wait for All Pods to Be Ready

The containers need some time to pull their images and start up. You can watch the status of the pods with the following command:
```bash
kubectl get pods --watch
```

Wait until all pods show 1/1 in the READY column and Running in the STATUS column. This may take a minute or two. Press Ctrl+C to exit the watch command once they are all running.

4. Access the Application

To access the UI, you need to forward a local port (for now) to the nginx service, which acts as the entry point for the application.
```bash
kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80
```

You will see a message like Forwarding from 127.0.0.1:8080 -> 80. Now, you can open your web browser and navigate to:

http://localhost:8080

You should see the application's frontend and be able to interact with it fully.

Furthermore, you can access the APIdocs by navigating:
- **App-service API Docs (Swagger)**: http://localhost:8080/app/apidocs
- **Model-service API Docs (Swagger)**: http://localhost:8080/model/apidocs

### Cleaning Up

Once you are finished, you can remove the resources from your cluster.

To delete all the Kubernetes resources created by the Helm chart (Deployments, Services, etc.), but keep your Minikube cluster running:
```bash
helm uninstall remla-app
```

To completely delete the local Minikube cluster and all its contents:
```bash
minikube delete
```

