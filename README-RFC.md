# RFC: Requisitos para un Sistema de Orquestación de TI

# Table of contents

1. [Introducción](#introducci-n)
2. [Requisitos](#requisitos)
3. [Solución](#solucion)
4. [Referencias](#referencias)

## Introducción

En la actualidad, las organizaciones de todo tipo requieren de sistemas ágiles que les permitan afrontar una economia que cambia todo el tiempo. Esto siempre trae nuevos retos, los desarrollos de software son más ágiles, las entregas de productos son cada vez más frecuentes y requieren integrar el control de calidad durante todo el ciclo de vida del sistema.

Para áreas de tecnología como infraestructura esto trae retos importantes ya que cada vez son más frecuentes los requisitos para aprovisionar nuevos ambientes o plataformas para desarrollar nuevos productos o servicios, para realizar pruebas de calidad y otras etapas por las que pasa un nuevo producto, esto incluye retirar servicios obsoletos.

Estas herramientas deben permitir gestionar de forma consistnte las configuraciones de los sistemas, automatizar tareas como la gestión de configuraciones, el despliegue de aplicaciones y la orquestación de cambios en TI.

## Requisitos

Lo que se busca es desarrollar un sistema que permita ejecutar las mejores prácticas de Infrastructure as Code en la plataforma iTop para agilizar los procesos de puesta a producción de nuevos desarrollos y servicios. El sistema debe permitir la orquestación de TI, por lo tanto debe ir más allá de lo que comunmente se conoce como "Configuration Management" que es bien conocido en la gestión de infraestructura de TI.

El sistema debe permitir orquestar cambios en las diferentes aplicaciones, bases de datos y servicios de infraestructura de TI que requiera el cambio, este sistema debe descargar de este trabajo a administradores de bases de datos, diseñadores y desarrolladores web y duro, así como de requerir intervensión local de un ingeniero en sitio con privilegios de administrador.

El sistema debe permitir almacenar el código del sistema en un sistema de control de versiones colaborativo, se debe poder construir en cadena para servir propositos comunes en diferentes proyectos de forma homologada y permitir visibilidad de los cambios, autorizaciónes y otros recursos necesarios para tener un mejor control de cambios en los servicios de TI y nos permita contestar la siguiente pregunta: "Cuantos cambios han sido exitosos la primer vez?".

Los cambios que debemos controlar con este sistema son de 4 tipos:

* Actualizaciones en Aplicaciones y Bases de datos
* Actualizaciones regulares de Sistema Operativo, Application and Database Stack
* Actualizaciones de seguridad de OS, Application and Database Stack
* Cambios de configuraciones en las diferentes capas

Por lo tanto se requiere un sistema que involucre a:

 * Procesos
 * Personas
 * Tecnología

El sistema debe ser:

 * Sencillo
 * Seguro
 * Confiable
 * Policy Compliant
 * Flexible

Se requiere que el sistema este basado en software libre y este respaldado por una gran comunidad a lo largo del tiempo.

A nivel funcional debe poseer las siguientes caracteristicas técnicas:

 * Detección de estados y transiciones de una declaración.
 * Consulta de hechos/facts desde diferentes fuentes, ejemplo DB o SNMP.
 * Automatización de configuraciones de sistema en servidores GNU/Linux.
 * Automatización del despligue de nuevas aplicaciones y sus dependencias del stack.
 * Aprovisionamiento de servidores con plataformas de virtualización o nube a través de plugins o API.
 * Uso de inventarios estáticos y dinámicos, así como la agrupación y filtrados de nodos.
 * Flexible para manejar diferentes entornos, diferentes roles de servicios y dependencias entre ellos.
 * Uso de plantillas simples para aplicar configuraciones diferenes por entorno o grupo de servidores.
 * Integración con herramientas de monitorización como Nagios y Cacti.
 * Integración con herramientas de respaldos como rsync y Bacula.
 * Integración con Jenkins para la Integración Continua y Despliegue Continua.
 * Instalación minima y simple sin agente.
 * Baja curva de aprendizaje con lenguage declarativo simple de entender y de escribir.
 * Idempotency.
 * Orden en las declaraciones y ejecución de tareas.
 * Ejecución Paralela de trabajos.
 * Ejecución de comandos ad-oc.
 * Debe soportar la ejecución de scripts hechos en casa.

## Solución

### El Sistema

El sistema de orquestación de TI está alineado al proceso de puesta a producción de nuevos desarrollos y servicios, el sistema permite que el proceso fluya de forma continua con la adopción de diferentes mejores prácticas provenientes del desarrollo de software ágil y sus antecesores como Xtreme Programing y nuevas tendencias como DevOps.

El sistema depende de un flujo de trabajo donde se incorporan las siguientes prácticas y sistemas de trabajo:

 * Source Control: Git & Git flow
 * Code Review: Peer Review and Pull Requests
 * Testing: Automated Infrastructure Testing

El sistema incluye los siguientes componentes humanos y herramientas

 * Analyzers
 * Developers
 * Reviewers
 * Operators
 * Testers
 * Git/Bitbucket
 * Shell scripts
 * Ansible
 * Jenkins

### Git

 Se usa Git como sistema de control de versiones distribuido y colaborativo para que el equipo de operaciones de TI
 gestione el código de la infraestructura que se escribe para la automatización de los procesos.

 Usamos Bitbucket como servicio en la nube de Git, esté está integrado con Jenkins y Slack vía Webhooks y APIs.

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

## Referencias

En esta sección hacemos referencia a documentación que usamos de ejemplo para construir este sistema y su integración con otras herramientas de Orquestación de TI.

Orchestration (computing):
https://en.wikipedia.org/wiki/Orchestration_(computing)

Data-Orchestration-as-a-Service - Data integration in the age of the cloud. The T-Systems iPaaS solution powered by Informatica:
http://cloud.t-systems.com/solutions/enterprise-doaas

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
