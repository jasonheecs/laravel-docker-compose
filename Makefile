.PHONY: list

start:
	docker-compose start

stop:
	docker-compose stop

build:
	docker-compose up --build -d
	docker-compose run php composer create-project --prefer-dist laravel/laravel .

destroy:
	docker-compose down

rebuild:
	make destroy
	rm -rf ./src
	make build
	make start

connect:
	docker-compose exec php sh

list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs
