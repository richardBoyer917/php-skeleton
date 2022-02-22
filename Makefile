DOCKER=docker-compose -f ./docker/docker-compose.yml
# adapt
PHP=php80-fpm

coverage:
	$(DOCKER) run --rm $(PHP) php -dxdebug.mode=coverage ./vendor/bin/phpunit --coverage-text

# adapt project only
down:
	$(DOCKER) down --remove-orphans

fix:
	$(DOCKER) run --rm $(PHP) ./vendor/bin/php-cs-fixer fix

install:
	$(DOCKER) build
	$(DOCKER) run --rm $(PHP) composer install

phpstan:
	$(DOCKER) run --rm $(PHP) ./vendor/bin/phpstan analyse

psalm:
	$(DOCKER) run --rm $(PHP) ./vendor/bin/psalm --show-info=true

standards:
	$(DOCKER) run --rm $(PHP) ./vendor/bin/php-cs-fixer fix --dry-run -v

test: standards phpstan psalm coverage

# adapt
unit:
	$(DOCKER) run --rm php74-cli ./vendor/bin/phpunit
	$(DOCKER) run --rm $(PHP) ./vendor/bin/phpunit
	$(DOCKER) run --rm php81-cli ./vendor/bin/phpunit

# adapt project only
up:
	$(DOCKER) up -d
