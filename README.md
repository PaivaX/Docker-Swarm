Cloud Computing
===
O desenvolvimento da segunda parte do projeto, é a construção e configuração de um cluster, para servir uma página web em PHP, com base de dados SQL e websockets.


## Informação do projeto
- Titlo:  `Cloud Computing - virtualização usando docker`
- Autores:  `José Santos`,`Rui Paiva`

## Estrura de nodes
- 3 VM´s ubuntu:
  - Manager
  - worker1
  - worker2<br><br>


## Configuração
- Iniciar Swarm
  ```
  vagrant ssh swarm-manager
  sudo docker swarm init --advertise-addr 192.168.23.10
  ```
- Join em todas as VM´s** (colocar o token fornecido anteriormente)
  ```
  docker swarm join --token <token**> 192.168.23.10:2377
  ```
- Instalar o portainer no swarm-manager
  ```
  cd SHARED/
  docker stack deploy -c portainer-compose.yml portainer
  ```

- Instalar o portainer Agent
  ```
  ./start_portainer.sh
  ```

- Criar novo Environment
  
  No portainer Web, criar um Environment Agent, escolhendo um nome, ex: cloud-computing, e colocar o <IP_manager:9001>

  Não esquecer de alterar o Public IP, para o IP do manager.


- Instalar o nginx (quantas replicas? Substituir o "2")
  ```
  docker service create --name nginx-php --mount type=bind,source=/vagrant/app,target=/app --replicas 2 --publish 8080:80 webdevops/php-nginx:7.3

  ou (com ficheiro .conf)

  docker service create --name nginx --mount type=bind,source=/vagrant/app,target=/usr/share/nginx/html --mount type=bind,source=/vagrant/SHARED/nginx.conf,target=/etc/nginx/conf.d/default.conf --replicas 2 --publish 8080:80 nginx
  ```
  Após este passo, visitar: http://192.168.23.10:8080 e verificar se abre a página do NGINX.<br><br>

-  Instalar o POSTGRES
    ```
    docker stack deploy --compose-file=./postgres-compose.yml postgres
    ```
-  Instalar o PGADMIN**
    ```
    docker stack deploy --compose-file=./pgadmin-compose.yml pgadmin
    ```
-  Instalar o PROXY MANAGER
    ```
    docker stack deploy --compose-file=./proxy_manager-compose.yml proxy_manager
    ```
-  Instalar o NGINX Amplify
    ```
    sudo API_KEY='5188aa366ea80144f1b009d3ac4aa4e7' sh ./nginxamplify.sh
    ```

** Após instalar o PGADMIN, é necessário criar as tabelas no postgres. Aceder a http://192.168.23.10:5050

Dados para login:
    ```
    user="cloud@ipt.pt"
    | password="cloud"
    ```

Efetuar a ligação à BD, com os dados:

    ```
    hostname: "192.168.23.10"
    database: "cloud_computing"
    username: "cloud"
    password: "cloud"
    ```

 e importar o script SQl presente na pasta compose/postgres/dump.sql

 

## Gerir os serviços
- Escalar um serviço
  ```
  docker service scale <nome_do_serviço>=<num_replicas>
  ```
- Verificar as informações dos serviços a correr
  ```
  docker service ls
  ```
- Verificar em que nodes está a correr um serviço
  ```
  docker service ps <nome_serviço>
  ```
-
  ```
  docker node update --availability <drain|active> <nome_do_node>
  ```


<br>

## Directory Hierarchy
```
|—— .vagrant
|    |—— machines
|        |—— swarm-manager
|            |—— virtualbox
|                |—— action_provision
|                |—— action_set_name
|                |—— box_meta
|                |—— creator_uid
|                |—— id
|                |—— index_uuid
|                |—— private_key
|                |—— synced_folders
|                |—— vagrant_cwd
|        |—— swarm-worker1
|            |—— virtualbox
|                |—— action_provision
|                |—— action_set_name
|                |—— box_meta
|                |—— creator_uid
|                |—— id
|                |—— index_uuid
|                |—— private_key
|                |—— synced_folders
|                |—— vagrant_cwd
|        |—— swarm-worker2
|            |—— virtualbox
|                |—— action_provision
|                |—— action_set_name
|                |—— box_meta
|                |—— creator_uid
|                |—— id
|                |—— index_uuid
|                |—— private_key
|                |—— synced_folders
|                |—— vagrant_cwd
|    |—— rgloader
|        |—— loader.rb
|—— ubuntu-bionic-18.04-cloudimg-console.log
|—— Vagrantfile
```
## Comandos Úteis
### Docker
- Serviços existentes
  ```
  sudo docker service ps <nome_serviço>
  ```
- Mudar disponibilidade de um node
  ```
  docker node update --availability active <node-id>
  ```
### Comandos úteis

- Reiniciar o serviço Docker
  ```
  sudo service docker restart
  ```

- Reiniciar um serviço
  ```
  sudo docker service update --force <nome_do_servico>
  ```
## References
- [docker.com - deploy service](https://docs.docker.com/engine/swarm/swarm-tutorial/deploy-service/)
- [docker.com - swarm](https://docs.docker.com/engine/swarm/services/)
- [code-1](https://github.com)
- [code-2](https://github.com)
  
