# README: http://makefiletutorial.com

# Adding PHONY to a target will prevent make from confusing the phony target with a file name.
# In this case, if `test` folder exists, `make test` will still be run.
.PHONY: test build teardown up publish

build:
	@docker-compose build

# NOTE: Find out more about use of logical OR operators in bash:
# https://bash.cyberciti.biz/guide/Logical_OR
dev:
	@docker-compose -f docker-compose.yml -f docker-compose.dev.yml run --rm tools

release-up:
	@docker-compose up -d && sleep 5 && \
		echo "OK: Successfuly launched all the required components..."

test:
	@docker-compose exec -T tools bats /test && \
		echo "OK: Successfuly passed all the tests for this build of etcd..."

teardown:
	@docker-compose down && \
		echo "OK: Successfuly shutdown and removed all the required components..."

publish:
	@docker login -u="$$(kontena vault read --value DOCKER_USERNAME)" -p="$$(kontena vault read --value DOCKER_PASSWORD)" && \
		docker-compose push etcd && \
		echo "OK: Successfuly published 'etcd' image..."