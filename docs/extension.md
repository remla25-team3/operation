# Extension: Integrating Flux as a GitOps Approach for CI/CD

In our current CI/CD setup we have automated image building and version tagging, the deployment step itself still requires manually triggered or scripted actions to apply the Kubernetes manifests and Helm charts. This approach can introduce human errors, slow down the release process, and cause discrepancies between the desired state in Git and the actual state running in the cluster as the deployment stays at the momemt of latest apply. Moreover, tracing deployments and performing rollbacks tend to be harder and error-prone due to this lack of automation and synchronization.

GitOps is a modern operational framework that uses Git repositories as the single source of truth for declarative infrastructure and application deployments. Instead of manually running commands or scripts to change the cluster state, GitOps tools continuously monitor Git repositories and automatically synchronize the live environment to match the declared configuration. This approach enables version-controlled, auditable and automated deployments.

To overcome the challenges in our current deployment process, we propose to integrate Flux into our Kubernetes cluster as a GitOps operator. Flux continuously monitors the Git repository where all deployment configurations reside and ensures that the cluster state always matches this declared configuration. This transforms the deployment process into a fully automated, declarative pipeline that reduces errors and improves the deployment pipeline.

| **Current Shortcomings**                                  | **Flux**                              |
|-----------------------------------------------------------|------------------------------------------------------------|
| Deployments require manual application of manifests or Helm charts, prone to human error and delays. | Automatic synchronization of cluster state with Git, eliminating manual deployment steps. |
| Lack of guaranteed consistency between Git repository and deployed cluster state; possible drift over time. | Continuous reconciliation ensures cluster state always matches Git, preventing drift. |
| Rollbacks are manual and complex, requiring careful re-application of old manifests. | Rollbacks are as simple as reverting Git commits; Flux applies changes automatically. |
| Difficult to audit which deployment corresponds to which change due to manual processes. | Every deployment is linked to a specific Git commit, enhancing auditability and traceability. |
| Limited visibility on deployment status and reconciliation health. | Flux provides detailed status reports and alerts on deployment success or failure. |
| SSH access to cluster nodes is required to run `helm upgrade` or `kubectl apply` commands manually or trigger any workflows. | No need to SSH into nodes; Flux automatically applies changes by syncing with Git, streamlining operations. |


## Steps to implement
1. Install Flux CLI both on the cluster and on the local machine by following [this](https://fluxcd.io/flux/installation/)

2. Bootstrap Flux into the cluster
   Use the Flux CLI to bootstrap Flux into your Kubernetes cluster, connecting it to your Git repository containing deployment manifests or Helm charts. For example:  
   ```bash
   flux bootstrap github \
     --owner="remla25-team3" \
     --repository="operation" \
     --branch=main \
     --path=cluster
3. Define the deployed helmresources as [HelmReleases](https://fluxcd.io/flux/guides/helmreleases/)
4. Watch flux automatically take care of the deployment and syncronization :) 
## General Solution
  The proposed GitOps approach using Flux is broadly applicable across diverse projects and environments that leverage Kubernetes. The principles of declarative configuration, automated reconciliation, and version-controlled infrastructure are universal and can be integrated into CI/CD pipelines for any cloud-native application. This has been one of the latest industry trends by companies using Kubernetes clusters as can be seen by the blog of RBC Capital Markets on CNCF: [Blog RBC](https://www.cncf.io/blog/2025/05/22/streamlining-application-deployment-on-kubernetes-at-rbc-capital-markets-a-journey-with-fluxcd/)

---

### References

- [Flux official documentation](https://fluxcd.io/docs/)
- [GitOps Principles by Weaveworks](https://www.weave.works/technologies/gitops/)
- [Continuous Deployment Best Practices](https://www.weave.works/blog/gitops-why-and-how)
