git-client
=========

The purpose of this role is to install the git client and setup ssh client on linux hosts, so it can connect securely to remote git repository and deploy application and infrastructure code.

Requirements
------------

Ubuntu based system.

Role Variables
--------------

You need to setup global variables on inventory, or role defaults, something linke this:

 - infra_git_server_address: bitbucket.org
 - infra_git_server_port: 22
 - infra_git_server_user: git
 - itop_git_server_address: bitbucket.org
 - itop_git_server_port: 22
 - itop_git_server_user: git

Dependencies
------------

Your need to create ssh keys for jenkins and ansible for each project, for example:

$ ssh-keygen -t rsa -b 4096 -C "jenkins@example.com" -f id-local-jenkins.rsa
$ ssh-keygen -t rsa -b 4096 -C "ansible@example.com" -f id-local-ansible.rsa


Example Playbook
----------------

To use this role, just include it in your playbook, for example:

    - hosts: servers
      roles:
         - git-client

License
-------

MIT

Author Information
------------------

Please any question, please contact the autor at: jorge.medina@koolops.com.mx.
