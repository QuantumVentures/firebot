## Firebot

## Setup

#### Build Image
```
$ docker build -t [tag_name] .
```

#### Create Database
```
$ docker run -e DB_HOST=[ip] -e DB_PORT=[port] -e DB_PASSWORD=[password] -e DB_USERNAME=[username] -e SECRET_KEY_BASE=$(rake secret) [tag_name] bundle exec rake db:create RAILS_ENV=[environment]
```

#### Migrate Database
```
$ docker run -e DB_HOST=[ip] -e DB_PORT=[port] -e DB_PASSWORD=[password] -e DB_USERNAME=[username] [tag_name] bundle exec rake db:migrate RAILS_ENV=[environment]
```

#### Start Server
```
$ docker run -d -p 8080:8080 -e DB_HOST=[ip] -e DB_PORT=[port] -e DB_PASSWORD=[password] -e DB_USERNAME=[username] --name app [tag_name]
```

#### Nginx link to app
```
$ docker run -d -p 80:80 --link app:app --volumes-from app --name nginx-unicorn dangerous/nginx-unicorn

## CoreOS Cloud Config
```
#cloud-config

# Validate cloud-config: https://coreos.com/validate/

coreos:
  etcd:
    # generate a new token for each unique cluster from
    # https://discovery.etcd.io/new?size=3
    # specify the intial size of your cluster with ?size=X
    discovery: https://discovery.etcd.io/ba4cbcd9ef071f296a40e7ffc12529bc
    # multi-region and multi-cloud deployments need to use $public_ipv4
    addr: $private_ipv4:4001
    peer-addr: $private_ipv4:7001
  units:
    - name: etcd.service
      command: start
    - name: fleet.service
      command: start

    - name: app.service
      command: start
      content: |
        [Unit]
        Description=Ruby on Rails application w/ Unicorn
        After=docker.service
        Requires=docker.service

        [Service]
        User=core
        TimeoutStartSec=0
        ExecStartPre=-/usr/bin/docker kill app
        ExecStartPre=-/usr/bin/docker rm app
        ExecStartPre=/usr/bin/docker pull dangerous/firebot-backend
        ExecStart=/usr/bin/docker run -p 8080:8080 -e DB_HOST=[ip] -e DB_PORT=[port] -e DB_PASSWORD=[pwd] -e DB_USERNAME=[name] -e SECRET_KEY_BASE=[rake secret] --name app dangerous/firebot-backend
        ExecStop=/usr/bin/docker stop app
    - name: nginx.service
      command: start
      content: |
        [Unit]
        Description=Nginx w/ linking to Ruby on Rails & Unicorn container
        After=app.service
        Requires=app.service

        [Service]
        User=core
        TimeoutStartSec=0
        ExecStartPre=-/usr/bin/docker kill nginx-unicorn
        ExecStartPre=-/usr/bin/docker rm nginx-unicorn
        ExecStartPre=/usr/bin/docker pull dangerous/nginx-unicorn
        ExecStart=/usr/bin/docker run -p 80:80 --link app:app --name nginx-unicorn --volumes-from app dangerous/nginx-unicorn
        ExecStop=/usr/bin/docker stop nginx-unicorn
