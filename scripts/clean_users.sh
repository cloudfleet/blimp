supervisorctl restart conduit
docker rm -f mailpile-xyz
rm /opt/cloudfleet/apps/musterroll/data/users.json 
docker rm -f musterroll
(cd scripts/ansible &&         ansible-playbook blimp-start.yml --skip-tags=skip-physical-blimp)

