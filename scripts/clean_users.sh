supervisorctl restart conduit
docker rm -f `docker ps -aq`
docker rm -f musterroll
rm /opt/cloudfleet/common/users.json
rm /opt/cloudfleet/conf/port-assignments.json
(cd scripts/ansible && ansible-playbook blimp-start-containers.yml --skip-tags=skip-physical-blimp)
