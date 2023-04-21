### Hexlet tests and linter status:
[![Actions Status](https://github.com/Vomblr/devops-for-programmers-project-77/workflows/hexlet-check/badge.svg)](https://github.com/Vomblr/devops-for-programmers-project-77/actions)

Final Hexlet DevOps project

## Release tutorial

### Step 1. Setup Yandex Cloud

1. Create account on Yandex Cloud and install Yandex CLI
2. Create a [service account](https://cloud.yandex.com/en/docs/iam/operations/sa/create) with [the editor](https://cloud.yandex.com/en/docs/iam/concepts/access-control/roles#editor) role.
3. Create an [authorized key](https://cloud.yandex.com/en-ru/docs/tutorials/infrastructure-management/terraform-quickstart#install-terraform) for your service account and put the file key.json to /terraform folder.

### Step 2. Setup DataDog monitoring

1. Create a DataDog account
2. Save api_token and app_token to vars

### Step 3. Setup Ansible

1. Install Ansible.
2. `make install-roles`

### Step 4. Create necessary keys and passwords

1. Generate ssh keys for the Yandex Cloud VM's: `make generate-ssh-keys`
2. Create ansible vault password: `make vault-create-password password=password`
    1. Note: password is saved in the `vault-password` file. It's added to gitignore.

### Step 5. Create terraform infrastructure

1. Set variables in the [vars.yml](./ansible/group_vars/all/vars.yml)
2. Setup terraform infrastructure: `make terraform-setup`

### Step 6. Setup webservers

1. Set variables in the [vars.yml](./ansible/group_vars/webservers/vars.yml)
2. `make install-packages`

### Step 7. Release application

1. `make deploy-app`

## Test deployed application

Application will be deployed at [askdmitry.space](https://askdmitry.space).

## Make commands

SSH

- connect to the host "web2": `make ssh HOST=web2`

Ansible

- encrypt variables for the "all" group: `make vault-encrypt GROUP=all`
- view variables for the "webservers", set vault filename: `make vault-view GROUP=webservers`

Terraform

- plan setup: `make terraform-plan-setup`
- destroy infrastructure: `make terraform-destroy`
- get output: `make -s terraform-show-output`
- get output for the "mysql_host" value: `make -s terraform-show-output NAME=mysql_host`
