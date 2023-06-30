Cloud Computing
===
Abstract:xxx
## Papar Information
- Title:  `paper name`
- Authors:  `José Santos`,`Rui Paiva`
- Preprint: [https://arxiv.org/abs/xx]()
- Full-preprint: [paper position]()
- Video: [video position]()

## Install & Dependence
- python
- pytorch
- numpy

## Use
- Iniciar Swarm
  ```
  sudo docker swarm init --advertise-addr 192.168.23.10
  ```
- Join em todas as VM´s
  ```
  docker swarm join --token <token> 192.168.23.10:2377
  ```
- Instalar o portainer
  ```
  docker stack deploy -c docker-compose.yml portainer
  ```
- Instalar o nginx (quantas replicas?)
  ```
  docker service create --name nginx --replicas <2> --publish 8080:80 nginx
  ```


## Pretrained model
| Model | Download |
| ---     | ---   |
| Model-1 | [download]() |
| Model-2 | [download]() |
| Model-3 | [download]() |


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
## Code Details
### Tested Platform
- software
  ```
  OS: Debian unstable (May 2021), Ubuntu LTS
  Python: 3.8.5 (anaconda)
  PyTorch: 1.7.1, 1.8.1
  ```
- hardware
  ```
  CPU: Intel Xeon 6226R
  GPU: Nvidia RTX3090 (24GB)
  ```
### Hyper parameters
```
```
## References
- [docker.com](https://docs.docker.com/engine/swarm/swarm-tutorial/deploy-service/)
- [paper-2]()
- [code-1](https://github.com)
- [code-2](https://github.com)
  
## License

## Citing
If you use xxx,please use the following BibTeX entry.
```
```
