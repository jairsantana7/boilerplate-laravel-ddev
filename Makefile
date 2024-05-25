SHELL := /bin/bash # Use bash syntax
.PHONY: run in mysql stop clean build storybook

# Configure environment.
# ----------------------

ifneq ($(MAKECMDGOALS),clean)
-include .env
endif

export TZ=America/Sao_Paulo
export USER_ID=$(shell id -u)

# @TODO Hack for MacOSX or other OS which has the same group id
#	   than the containers user.
export GROUP_ID=$(shell if [ `id -g` == '20' ]; then echo '1000'; else echo `id -g`; fi)

BASE_PATH=/var/www/html
EXEC_IN_PROJECT_APP=ddev exec

in:
	ddev auth ssh
	ddev ssh

install:
	ddev composer install
	#make pre-install
	#ddev auth ssh
	#ddev start
	#make import-db

start:
	ddev start

stop:
	ddev stop

prune:
	ddev stop --unlist laravel

restart:
	ddev restart

in-mysql:
	ddev mysql

in-redis:
	docker exec -it $(PROJECT_NAME)-redis redis-cli

exec:
	ddev exec $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

yarn:
	ddev yarn --cwd . $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

npm:
	ddev npm --cwd . $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

dev:
	ddev yarn dev

share:
	ngrok http 3001

artisan:
	ddev artisan $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

seed:
	ddev artisan migrate:reset
	ddev artisan migrate
	ddev php artisan db:seed
	ddev artisan db:seed --class=RolesTableSeeder
	#ddev artisan migrate:refresh --seed

drop:
	ddev stop --remove-data && ddev start

migration:
	ddev artisan make:migration create_$(filter-out $@,$(MAKECMDGOALS))_table
    %:
    	@:

git_add:
	git remote add origin $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

model:
	ddev artisan make:model $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

model-m:
	ddev artisan make:model $(filter-out $@,$(MAKECMDGOALS)) -m
%:
	@:

model-mf:
	ddev artisan make:model $(filter-out $@,$(MAKECMDGOALS)) -mf
%:
	@:

stub:
	ddev artisan stub:publish

migrate:
	ddev artisan migrate

reset_db:
	ddev artisan migrate:reset

config:
	ddev artisan config:publish

event:
	ddev artisan make:event

listener:
	ddev artisan make:listener

list_events:
	ddev php artisan event:list

route_list:
	ddev php artisan route:list

controller:
	ddev artisan make:controller $(filter-out $@,$(MAKECMDGOALS)) -r
%:
	@:

git:
	git add .
	git commit -m "$(filter-out $@,$(MAKECMDGOALS))"
	git push
%:
	@:

cr:
	rm -rf bootstrap/cache/*.php
	ddev php artisan route:clear
	ddev php artisan cache:clear
	ddev php artisan route:cache
	ddev php artisan config:cache
	ddev php artisan view:clear
	ddev php artisan view:cache
	ddev php artisan filament:cache-components


middleware:
	ddev artisan make:middleware $(filter-out $@,$(MAKECMDGOALS))
%:
	@:

new:
	ddev composer global require laravel/installer
	ddev exec composer create-project --prefer-dist laravel/laravel . $(filter-out $@,$(MAKECMDGOALS))
%:
	@: