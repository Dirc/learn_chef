# Learn Chef Dockerfile

## Build dockerfile

```bash
docker build -t chefdk .
```

## Run image

```bash
docker run -it -p 8100:80 chefdk /bin/bash
```

## Inside container run

```bash
chef-client --local-mode /root/chef-repo/recipe_helloworld/hello.rb
```

```bash
chef-client --local-mode /root/chef-repo/recipe_helloworld/goodbye.rb
```

```bash
chef-client --local-mode /root/chef-repo/recipe_helloworld/webserver.rb
```

## Verify apache
On your workstation, browse to <http://localhost:8100/>

