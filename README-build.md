# Construyendo un Sistema de Orquestación de TI con Ansible y Jenkins

# Table of contents

1. [Introducción](#introducci-n)
2. [Requisitos](#requisitos)
3. [Construcción](#construccion)
4. [Despliegue](#despliegue)
5. [Limpiando](#limpiando)
7. [Destruyendo](#destruyendo)
8. [Mejores prácticas](#mejorespracticas)
9. [Contribuyendo](#contribuyendo)
10. [Referencias](#referecias)

## Introducción

Esta es la guía que te permitirá construir un sistema Orquestación de TI con Ansible y Jenkins. El sistema de orquestación de TI esta diseñado para ayudar a optimizar las tareas de rutina y mantenimientos de los equipos de operaciones de TI, tanto en los procesos operativos, como en los de infraestructura.

### Objetivos

El objetivo de esta guía es simplificar el proceso de construcción de un sistema de orquestación de TI con Ansible y Jenkins.

- Definir los requisitos del flujo del sistema
- Introducir Git y Git Flow
- Introdución a Ansible
- Introducción a Jenkins
- Como construir un ambiente de desarrollo local con vagrant
- Como limpiar y destruir el ambiente vagrant

## Requisitos

### El Flujo

Para optimizar los procesos de puesta a producción de nuevos desarrollos y servicios,
involucraremos tanto a personas, sistemas y datos. El sistema de orquestación de TI depende de un flujo de trabajo colaborativo entre las diferentes funciones de las operaciones de TI, este flujo de trabajo esta basado en principios y prácticas del desarrollo de software ágil como eXtreme Programming, Agile, Continuous Delivery, Infrastructure as Code y DevOps.

Por lo tanto, nuestro flujo de trabajo está basado en un Pipeline de Continuous Delivery, se ve así:

SCM -> BUILD -> TEST -> DEPLOY

Todos los scripts, archivos de configuración, plantillas, playbooks estarán almacenados en un repositorio de código basado en Git para mantenerlo versionado, para esto usaremos la plataforma Bitbucket con repositorios privados, sin embargo, se pueden usar otras plataformas como Github, o usar GitLab en infraestructura privada.

Para mantener un mejor control de cambios en el código fuente de la infraestructura, usaremos un flujo de trabajo basado en branches para las diferentes fases del desarrollo, pruebas y produción, por lo tanto nuestro flujo de trabajo estará basado en Git Flow.

### Ansible

Con Ansible podremos automatizar las siguiente tareas y reducir los tiempos de entrega al tener procedimientos repetibles y reproducibles:

* Aprovisionamiento de servidores físicos, máquinas virtuales e instancias en la nube
* Instalación y configuracon inicial de servidores
* Instalación y configuración de servicios de infraestructura
* Instalación y configuración de aplicaciones y bases de datos.
* Orquestación para realizar tareas complejas donde involucre más de un sistema, como pueden ser sistemas de respaldos, monitorización, balanceadores de carga, clusters, etc.

Ansible es una herramienta diseñada para ayudar a las organizaciones en automatizar las actividades de administración de configuraciones, despliegue de aplicacinoes y orquestación de TI.

Ansible puede ser usado tanto por equipos de desarrollo para incluir en su código las instrucciones para deployar la aplicación y para operaciones de TI en orquestar los despliegues de ambientes, tanto físicos y virtuales.

### Jenkins

Con Jenkins automatizamos la ejecución de tareas como Build y Test del código de la infraestructura, y también la ejecución de los playbooks de Ansible para orquestar diferentes tareas de aprovisionamiento de ambientes de TI, Gestión de Configuraciones y Despliegue de bases de datos, aplicativos y servicios de infraestrucutra y comunicaciones.

### Integración Ansible Jenkins

Se instaló el plugin Ansible en Jenkins para ejecutar los playbooks de Ansible desde la interfaz web de Jenkins, esto permite ejecutar de forma controlada los trabajos de ansible.

## Construcción

Para construir un ambiente de desarrollo local para el sistema de orquestación de TI usaremos el comando make y las configuraciones definidas en el archivo Makefile.

Ejecutaremos el subproceso vagrant para crear un ambiente de desarrollo local basado en Vagrant y Virtualbox, crearemos una máquina virtual basada en la distribución GNU/Linux Ubuntu server 16.04 de 64-bits, esta máquina se llama devops y será donde construiremos el sistema de orequestación.

Ejecuta el siguiente procedimiento dentro del directorio en el cual descargaste el repositorio de git, por ejemplo:

```shell
$ make vagrant
```

Una vez que las máquinas virtuales se hayan creado, continuamos el proceso de construcción del sistema de orquestación.

Lo primero que debes hacer es conectarte a la máquina devops, por ejemplo:

```shell
$ vagrant ssh devops
Welcome to Ubuntu 16.04.2 LTS (GNU/Linux 4.4.0-75-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

0 packages can be updated.
0 updates are security updates.


vagrant@devops:~$
```

Una vez que estés dentro de la máquina virtual devops, escala privilegios a la cuenta root y cambiate al directorio /vagrant, por ejemplo:

```shell
vagrant@devops:~$ sudo -i

root@devops:~# cd /vagrant

```

Continuaremos usando make para ejecutar los diferentes subprocesos que nos permitirán consturir el sistema de orquestación de TI.

Primero debemos hacer el bootstrap del sistema, es decir, instalaremos ansible y todos su requisitos para empezar a construir el sistema de orquestación.

```shell
root@devops:/vagrant# make bootstrap
```

Después de haber terminado el bootstrap en el sistema devops, ejecuta el subproceso build para construir el ambiente de desarrollo local y las personalizaciones para ansible.

```shell
root@devops:/vagrant# make build
```

Si el subproceso de build para el entorno de desarrollo local termina exitosamente, ejecuta el subproceso de test para validar la sintaxis de los playbooks de Ansible.

```shell
root@devops:/vagrant# make test
```

## Despliegue

Después de haber construido el ambiente de desarrollo local para el sistema de orquestación, lo deployamos en la máquina virtual devops, por ejemplo:

```shell
root@devops:/vagrant# make deploy
```

Una vez que termine el proceso de deploy, ingresa a la consola de Jenkins desde el navegador en tu equipo local apuntando al siguiente URL: http://localhost:1088.

NOTA: El puerto 1088 está definido en la configuración de vagrant, este puerto se abre en el localhost y es re enviado al puerto 8080 de la maquina devops.

Las credenciales de acceso a Jenkins predefinidas son:

 - Usuario: admin
 - Contraseña: admin

Para conocer más acerca del uso de Jenkins sig  ue con la guía operación del sistema de orquestación de TI.

## Limpieza

Si realizaste cambios en la configuración de ansible y su inventario local y deseas revertir los cambios ejecuta make con el parámetro clean, por ejemplo:

```shell
root@devops:/vagrant# make clean
```

IMPORTANTE: Este comando debe ejecutarse en la máquina virtual devops.

## Destruyendo

Para destruir el ambiente de desarrollo local que creaste, debes ejecutar el comando make con el parámetro destroy, por ejemplo:

```shell
$ make destroy
```

IMPORTANTE: Este comando debe ejecutarse en tu equipo local, en donde corre vagrant.

## Mejores prácticas

Estos playbooks se deben alinear a la estructura actual de ansible que es proyecto:clase servidor:tipo servidor: centro servidor.

Para construir la estructura del rol se debe usar ansible-galaxy, el nombre debe ser rol-service.

IMPORTANTE: Los roles deben usar guión medio para separar las palabras que componen el nombre del rol, se aconseja que los nombres de los roles terminen con "-service".

Se deben seguir las mejores prácticas de edición en relación a :

 * Escribir nombres de tareas descriptivas y en inglés.
 * Identado basado en espacios en blanco.
 * Lineas en blanco para separar cada tarea
 * Uso de variables en formato ansible 2.x, ejemplo ansible_ssh_host en lugar de ansible_host.
 * Uso de variables especificas para el componente en vars/main.yml.
 * Uso de variables especificas para el ambiente en defaults/main.yml.
 * Uso de variables especificas para el centro en inventory/pmc/production.
 * Uso de variables estandar en base a el inventario o facts para evitar re escribir funciones de shell para capturar datos.
 * Se deben usar las funciones de python como split para sacar variables personalizadas siempre en base a variables exitentes en inventario, rol o fact.
 * Se deben usar tags para cada tarea, si son generales que se use la etiqueta general rol_service, note el guion bajo, no se usan guión medio "-".

Una vez desarrollado el playbook del rol, se debe agregar el rol al playbook de cada tipo de servidor abajo del rol de snmp-service.

Se deben documentar los tags en el documento de la matriz del sistema de gestión de configuraciones que se adjunta.

Los cambios deben integrarse al repositorio git ansible en la rama development y realizar un merge request para que se valide.

## Contribuyendo

Si desea contribuir al código se recomienda clonar el repositorio y trabajar en un feature branch o en development y hacer pull request para integrar a la rama master del ambiente de production.

La rama master está protegida para que solo usuarios con rol de owner o master puedan hacer commits, la forma más segura de integrar cambios es hacer pull request y peer review del código, para validarlo y probarlo en el ambiente de pruebas antes de poder integrar el código al ambiente productivo.

## Referencias

En esta sección hacemos referencia a documentación que usamos de ejemplo para construir este sistema y su integración con otras herramientas de Orquestación de TI.

Git:
https://git-scm.com

Git Flow:
https://danielkummer.github.io/git-flow-cheatsheet/

THE INSIDE PLAYBOOK - ORCHESTRATION, YOU KEEP USING THAT WORD:
http://www.ansible.com/blog/orchestration-you-keep-using-that-word

Jenkins - Building a software project
https://wiki.jenkins-ci.org/display/JENKINS/Building+a+software+project

ImmutableServer:
http://martinfowler.com/bliki/ImmutableServer.html

What do “immutable servers” and AWS environments have in common?:
https://elasticbox.com/blog/immutable-server-environments-in-aws/

Rethinking building on the cloud: Part 4: Immutable Servers:
https://www.thoughtworks.com/insights/blog/rethinking-building-cloud-part-4-immutable-servers

Jenkins - Ansible Plugin:
https://wiki.jenkins-ci.org/display/JENKINS/Ansible+Plugin

Automated Servers and Deployments with Ansible & Jenkins:
https://chromatichq.com/blog/automated-servers-and-deployments-ansible-jenkins

Continuous Integration, Delivery or Deployment with Jenkins, Docker and Ansible:
https://technologyconversations.com/2015/02/11/continuous-integration-delivery-or-deployment-with-jenkins-docker-and-ansible/

Vert.x featuring Continuous Delivery with Jenkins and Ansible:
http://vertx.io/blog/vert-x-featuring-continuous-delivery-with-jenkins-and-ansible/
