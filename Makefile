up: local files composer

local: dev

dev:
	docker-compose \
		-f .infrastructure/docker-compose/docker-compose.common.yml \
		-f .infrastructure/docker-compose/docker-compose.yml \
		 --env-file .env up -d --build --remove-orphans
	# docker exec php-fpm mkdir -p /application/public/employee/
	# docker exec php-fpm mkdir -p /application/public/uploads/files/
	# docker exec php-fpm chmod -R 777 /application/public/employee/
	# docker exec php-fpm chmod -R 777 /application/public/uploads/files/

common:
	docker-compose -f .infrastructure/docker-compose/docker-compose.common.yml --env-file .env up -d --build

main:
	docker-compose -f .infrastructure/docker-compose/docker-compose.yml --env-file .env up -d --build

composer:
	docker exec -t php-fpm bash -c 'COMPOSER_MEMORY_LIMIT=-1 composer install  --no-interaction'

php:
	docker exec -it php-fpm bash
files:
	docker exec php-fpm chmod -R 777 /application/storage/logs
	docker exec php-fpm chmod -R 777 /application/storage/framework
