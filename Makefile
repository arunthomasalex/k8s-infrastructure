include .env
export

DELAY=10

RED:=\033[0;31m
GREEN:=\033[0;32m
ORANGE:=\033[0;33m
NOCOLOR:=\033[0m

master_ids=$(shell cd terraform && terraform output --json k8s-master-ids | sed -r 's/(,|\[|\])/ /g')
cluster_ids=$(shell cd terraform && terraform output --json k8s-cluster-ids | sed -r 's/(,|\[|\])/ /g')

edit: terraform wait ansible provisioned

clean: ansible-destroy terraform-destroy destroyed

wait:
	@echo "${ORANGE}Waiting for ${DELAY} seconds.${NOCOLOR}"
	@sleep ${DELAY}

terraform: terraform-init terraform-plan terraform-apply

ansible: ansible-init ansible-exec ansible-destroy

ansible-init:
	@echo "${ORANGE}Initializing ansible tmp files${NOCOLOR}"
	@mkdir ansible/.tmp

ansible-exec:
	@echo "${ORANGE}Executing scripts on remote machines${NOCOLOR}"

ansible-destroy:
	@echo "${RED}Destroying ansible tmp files${NOCOLOR}"
	@rm -rf ansible/.tmp

terraform-init:
	@echo "${ORANGE}terraform init${NOCOLOR}"
	@cd terraform && \
	terraform init -upgrade

terraform-plan:
	@echo "${ORANGE}terraform plan${NOCOLOR}"
	@cd terraform && \
	terraform plan -out=out.tfplan

terraform-apply:
	@echo "${ORANGE}terraform apply${NOCOLOR}"
	@cd terraform && \
	terraform apply -auto-approve out.tfplan

terraform-destroy:
	@echo "${RED}terraform destroy${NOCOLOR}"
	@cd terraform && \
	terraform destroy -auto-approve

terraform-output:
	@echo "${GREEN}terraform apply${NOCOLOR}"
	@cd terraform && \
	terraform output --json

provisioned:
	@echo "${GREEN}Completed provisioning${NOCOLOR}"

destroyed:
	@echo "${RED}Completely destroyed${NOCOLOR}"

start:
	@echo "${ORANGE}Starting k8s cluster instances${NOCOLOR}"
	aws ec2 start-instances --instance-ids $(cluster_ids)
	@aws ec2 wait instance-running --instance-ids $(cluster_ids)
	@echo "${GREEN}Started k8s master instances${NOCOLOR}"
	@echo "${ORANGE}Starting k8s master instances${NOCOLOR}"
	aws ec2 start-instances --instance-ids $(master_ids)
	@aws ec2 wait instance-running --instance-ids $(master_ids)
	@echo "${GREEN}Started k8s master instances${NOCOLOR}"

stop:
	@echo "${ORANGE}Stopping k8s master instances${NOCOLOR}"
	aws ec2 stop-instances --instance-ids $(master_ids)
	@aws ec2 wait instance-stopped --instance-ids $(master_ids)
	@echo "${RED}Stopped k8s master instances${NOCOLOR}"
	@echo "${ORANGE}Stopping k8s cluster instances${NOCOLOR}"
	aws ec2 stop-instances --instance-ids $(cluster_ids)
	@aws ec2 wait instance-stopped --instance-ids $(cluster_ids)
	@echo "${RED}Stopped k8s cluster instances${NOCOLOR}"