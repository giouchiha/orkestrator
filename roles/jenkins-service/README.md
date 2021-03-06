jenkins-service
=========

Tasks for setting up jenkins service.

Requirements
------------

Ubuntu based system.

Role Variables
--------------

jenkins_http_port: 8080
jenkins_url_prefix: ""
jenkins_home: /var/lib/jenkins
jenkins_hostname: localhost
jenkins_plugins:
  - 'ansible'
  - 'ansicolor'
  - 'greenballs'
  - 'timestamper'
  - 'ws-cleanup'
  - 'gradle'
  - 'ldap'
  - 'github'
  - 'dashboard-view'
  - 'nested-view'
  - 'slack'
  - 'pipeline-build-step'
  - 'pipeline-graph-analysis'
  - 'pipeline-input-step'
  - 'pipeline-milestone-step'
  - 'pipeline-model-api'
  - 'pipeline-model-declarative-agent'
  - 'pipeline-model-definition'
  - 'pipeline-rest-api'
  - 'pipeline-stage-step'
  - 'pipeline-stage-tags-metadata'
  - 'pipeline-stage-view'
  - 'workflow-job'
  - 'workflow-support'
  - 'workflow-aggregator'
  - 'workflow-basic-steps'
  - 'workflow-durable-task-step'
  - 'workflow-multibranch'
  - 'ssh-slaves'
  - 'docker-workflow'
  - 'shiningpanda'
  - 'xvfb'
  - 'test-results-analyzer'
  - 'simple-theme-plugin'
  - 'rebuild'
  - 'image-gallery'
# Proxy settings
proxy: no
proxy_host: localhost
proxy_port: 3128
proxy_login: login
proxy_password: password
proxy_url: "http://{{proxy_login}}:{{proxy_password}}@{{proxy_host}}:{{proxy_port}}"
__no_proxy: "localhost"
proxy_env:
  http_proxy: "{{proxy_url}}"
  https_proxy: "{{proxy_url}}"
  no_proxy: "{{__no_proxy}}"
#email:
#  smtp_host: 'mail.example.com'
#  smtp_ssl: 'true'
#  default_email_suffix: '@example.com'
# Jenkins admin credentials
jenkins_admin_username: admin
jenkins_admin_password: admin

Dependencies
------------

Not at the moment.

Example Playbook
----------------

To use this role, just include it in your playbook, for example:

    - hosts: servers
      roles:
        - jenkins-service

License
-------

MIT

Author Information
------------------

Please any question, please contact the autor at: jorge.medina@koolops.com.mx.
