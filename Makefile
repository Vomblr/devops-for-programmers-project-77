all: terraform-setup install-packages deploy-app

generate-ssh-keys:
	ssh-keygen -t rsa -f ~/.ssh/yandex/id_rsa

install-roles:
	ansible-galaxy install -r ansible/requirements.yml

vault-create-password:
	touch vault-password; \
	echo $(password) > vault-password

vault-encrypt:
	ansible-vault encrypt ansible/group_vars/$(GROUP)/vault.yml \
	--vault-password-file vault-password

vault-edit:
	ansible-vault edit ansible/group_vars/$(GROUP)/vault.yml \
	--vault-password-file vault-password

vault-view:
	ansible-vault view ansible/group_vars/$(GROUP)/vault.yml \
	--vault-password-file vault-password

terraform-plan-setup:
	ansible-playbook --vault-password-file vault-password \
	--check \
	--tags setup \
	ansible/terraform.yml

terraform-setup:
	ansible-playbook --vault-password-file vault-password \
	--tags setup \
	ansible/terraform.yml

terraform-destroy:
	ansible-playbook --vault-password-file vault-password \
	--tags destroy \
	ansible/terraform.yml

terraform-show-output:
	cd terraform; terraform output -json $(NAME); cd - > /dev/null

install-packages:
	ansible-playbook ansible/playbook.yml -i ansible/inventory.ini \
	 --vault-password-file vault-password --tags "setup" --ssh-extra-args "-F ssh_config"

deploy-app:
	 ansible-playbook ansible/playbook.yml -i ansible/inventory.ini \
	  --vault-password-file vault-password --tags "deploy" --ssh-extra-args "-F ssh_config"

ssh:
	ssh -F ssh_config $(HOST)
