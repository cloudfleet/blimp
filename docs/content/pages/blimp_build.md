Title: Building Sequence
Slug: blimp-build

This is the documentation of the Blimp's deployment.

Building the Docker image:

<div class="diagram">
docker build->install.sh: deps & \nstart ansible
install.sh->ansible/blimp_install.yml: set up pagekite, \nnginx, docker...
</div>

Starting the Docker container:

<div class="diagram">
docker run->start_docker.sh: if ARM build images, \nrun ansible
start_docker.sh->ansible/blimp_start.yml: start services, \nstart apps
</div>
