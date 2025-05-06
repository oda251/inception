run:
	docker-compose up --build


stop:
	docker-compose down

build:
	docker-compose build --no-cache

clean:
	rm -rf mariadb/data wordpress/data

re: clean run

.PHONY: run stop build clean