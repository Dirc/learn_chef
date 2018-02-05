# Learn Chef Dockerfile
Based on course beginners course on: https://learn.chef.io

The main difference is that the container is build useing a Dockerfile instead of typing multiple commands.

PRO: 
- Regenerate everything from code.
- Everything you do inside the container will be lost. (Volume is not dynamicaly shared between container and host)


## Setup chefdk container
Build dockerfile

```bash
docker build -t chefdk .
```

Run image

```bash
docker run -it -p 8100:80 chefdk /bin/bash
```

## Hello World recipe
Inside container run

```bash
chef-client --local-mode /root/chef-repo/recipe_helloworld/hello.rb
```

```bash
chef-client --local-mode /root/chef-repo/recipe_helloworld/goodbye.rb
```

```bash
chef-client --local-mode /root/chef-repo/recipe_helloworld/webserver.rb
```

Verify apache:

On your workstation, browse to <http://localhost:8100/>


## Cookbooks
Create yout first cookbook inside the chefdk container.

```bash
cd /root/chef-repo
mkdir cookbooks
chef generate cookbook cookbooks/learn_chef_apache2
```

Add html template

```Bash
chef generate template cookbooks/learn_chef_apache2 index.html
# html content
cat << EOF >> cookbooks/learn_chef_apache2/templates/index.html.erb
<html>
  <body>
    <h1>hello world</h1>
  </body>
</html>
EOF
```

Add recipe

```Bash
cat << EOF >> cookbooks/learn_chef_apache2/recipes/default.rb
apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end

package 'apache2'

service 'apache2' do
  supports status: true
  action [:enable, :start]
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
end

EOF
```

Run cookbook

```Bash
chef-client --local-mode --runlist 'recipe[learn_chef_apache2]'
```