up:
	mkdir -p /home/yoda/data && \
	mkdir -p /home/yoda/data/wp && \
	mkdir -p /home/yoda/data/db && \
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
	rm -rf /home/yoda/data/* && \
	docker container prune -f

buildup: build up

re: clean upbuild

.PHONY: up up-b stop build clean buildup re