up:
	docker-compose up 

up-b:
	docker-compose up --build

stop:
	docker-compose down

build:
	docker-compose build --no-cache

clean:
	rm -rf mariadb/data wordpress/data

buildup: build up

re: clean upbuild

.PHONY: up up-b stop build clean buildup re