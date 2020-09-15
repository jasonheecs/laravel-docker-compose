.PHONY: list
.SILENT: build

start:
	docker-compose start

stop:
	docker-compose stop

build:
	docker-compose up --build -d
	if [ ! -f "./src/.env" ]; then \
        docker-compose run php composer create-project --prefer-dist laravel/laravel .; \
    fi

destroy:
	docker-compose down -v

rebuild:
	@rm -rf ./src
	make destroy
	make build

connect:
	docker-compose exec php sh

list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs
