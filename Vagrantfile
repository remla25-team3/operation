NUM_WORKERS = 2
CPUS_CTRL = 2
CPUS_WORKER = 4
MEMORY_CTRL = 4096
MEMORY_WORKER = 4096 # lower for test purposes

Vagrant.configure("2") do |config|
  
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.box_version = "202502.21.0"
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

    ctrl.vm.hostname = "ctrl"

    #Resources
    ctrl.vm.provider "virtualbox" do |v|
      v.memory = MEMORY_CTRL
      v.cpus = CPUS_CTRL
    end

    #Networking
    ctrl.vm.network "private_network", ip: "192.168.56.100"

    # Removed provisioning here for parallel execution
  end
    
  (1..NUM_WORKERS).each do |i|
    config.vm.define "node-#{i}" do |node|

      node.vm.hostname = "node-#{i}"

      #Resources
      node.vm.provider "virtualbox" do |v|
        v.memory = MEMORY_WORKER
        v.cpus = CPUS_WORKER
      end

      #Networking
      node.vm.network "private_network", ip: "192.168.56.#{100 + i}"

      # Only provision from the last worker VM to enable parallel execution
      if i == NUM_WORKERS
        node.vm.provision :ansible do |a|
          a.compatibility_mode = "2.0"
          a.playbook = "provisioning/combined.yml"  # Use combined master playbook
          a.limit = "all"  # Target all VMs
          a.extra_vars = {
            num_workers: NUM_WORKERS
          }
          a.groups = ansible_groups
        end
      end
    end
  end
  
  #Dynamic inventory generation
  inventory = "[controller]\n"
  inventory += "ctrl ansible_host=192.168.56.100 ansible_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/ctrl/virtualbox/private_key\n\n"

  inventory += "[worker]\n"
  (1..NUM_WORKERS).each do |i|
    hostname = "node-#{i}"
    ip = "192.168.56.#{100 + i}"
    inventory += "#{hostname} ansible_host=#{ip} ansible_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/#{hostname}/virtualbox/private_key\n"
  end

  inventory += "\n[all:children]\ncontroller\nworker\n"

  # Write to provisioning/inventory.cfg
  File.write("provisioning/inventory.cfg", inventory)

end
