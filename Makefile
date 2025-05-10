up:
	cd srcs && \
	docker-compose up 

up-b:
	cd srcs && \
	docker-compose up --build

down:
	cd srcs && \
	docker-compose down

build:
	cd srcs && \
	docker-compose build --no-cache

clean:
	cd srcs && \
	rm -rf /home/yoda/data/*

buildup: build up

re: clean upbuild

.PHONY: up up-b stop build clean buildup re