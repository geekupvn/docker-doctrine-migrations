#### General
 - Migration database with docktrine migration
 - Support mysql & posgress
 - [Github](https://github.com/geekupvn/docker-doctrine-migrations)
 - [Docker Hub](https://hub.docker.com/r/geekupvn/doctrine-migration/tags)
#### Prepare
 - Pull docker image 
 ```
 docker pull geekupvn/doctrine-migration
 ```
 - Add to your Makefile
 ```
 dbmigrate-generate:
	docker run -v $(PWD)/migrations:/data geekupvn/doctrine-migration migration:generate

dbmigrate:
	docker run -v $(PWD)/migrations:/data geekupvn/doctrine-migration migration:migrate -n

dbmigrate-down:
	docker run -v $(PWD)/migrations:/data geekupvn/doctrine-migration migrations:migrate prev -n
 ```

 - copy migration config from `migrations` folder


 ``

#### Usage
- Create new migration
  ```
  make dbmigrate-generate
  ```

- Run migration
  ```
  make dbmigrate
  ```

- Rollback migration
  ```
  make dbmigrate-down
  ```

#### Limitation
 - Generated file migration with root permisssion on linux
 quick fix
 ```
    sudo chown your_user:your_user migrations/versions
 ```