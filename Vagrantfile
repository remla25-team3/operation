NUM_WORKERS = 2
CPUS_CTRL = 2
CPUS_WORKER = 1
MEMORY_CTRL = 4096
MEMORY_WORKER = 2048 # lower for test purposes

Vagrant.configure("2") do |config|
  
  # share host's ../shared folder to mnt/shared in all VMs
  config.vm.synced_folder "shared", "/mnt/shared"
  
  # Create Ansible groups
  ansible_groups = {
    "controller" => ["ctrl"],
    "worker" => (1..NUM_WORKERS).map { |i| "node-#{i}" },
    "all:children" => ["controller", "worker"]
  }

  # Controller VM
  config.vm.define "ctrl" do |ctrl|
    ctrl.vm.box = "bento/ubuntu-24.04"
    ctrl.vm.box_version = "202502.21.0"

    ctrl.vm.hostname = "ctrl"

    #step 1: Resources
    ctrl.vm.provider "virtualbox" do |v|
      v.memory = MEMORY_CTRL
      v.cpus = CPUS_CTRL
    end

    #step 2: Networking
    ctrl.vm.network "private_network", ip: "192.168.56.100"

    #step 3: Provision general.yml (common setup)
    ctrl.vm.provision :ansible do |a|
      a.playbook = "provisioning/general.yml"
      a.extra_vars = {
        num_workers: NUM_WORKERS
      }
      a.groups = ansible_groups
    end

    #step 4: Provision ctrl.yml (controller-specific)
    ctrl.vm.provision :ansible do |a|
      a.playbook = "provisioning/ctrl.yml"
      a.extra_vars = {
        num_workers: NUM_WORKERS
      }
      a.groups = ansible_groups
    end
  end
    
  (1..NUM_WORKERS).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.box = "bento/ubuntu-24.04"
      node.vm.box_version = "202502.21.0"

      node.vm.hostname = "node-#{i}"

      #step 1: Resources
      node.vm.provider "virtualbox" do |v|
        v.memory = MEMORY_WORKER
        v.cpus = CPUS_WORKER
      end

      #step 2: Networking
      node.vm.network "private_network", ip: "192.168.56.#{100 + i}"

      #step 3: Provision general.yml (common setup)
      node.vm.provision :ansible do |a|
        a.playbook = "provisioning/general.yml"
        a.extra_vars = {
          num_workers: NUM_WORKERS
        }
        a.groups = ansible_groups
      end

      #step 4: Provision node.yml (worker-specific)
      node.vm.provision :ansible do |a|
        a.playbook = "provisioning/node.yml"
        a.extra_vars = {
          num_workers: NUM_WORKERS
        }
        a.groups = ansible_groups
      end
    end
  end
  
end
