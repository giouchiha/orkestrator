common
=========

Common tasks for Linux Servers

Requirements
------------

Ubuntu based system.

Role Variables
--------------

# defaults file for common
  locale: en_US.UTF-8
  timezone: America/Mexico_City
  default_shell: /bin/bash


Dependencies
 -----------

Not at the moment.

Example Playbook
----------------

To use this role, just include it in your playbook, for example:

    - hosts: servers
      roles:
         - common

License
-------

MIT

Author Information
------------------

Please any question, please contact the autor at: jorge.medina@koolops.com.mx.
