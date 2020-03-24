# README: http://makefiletutorial.com

# Adding PHONY to a target will prevent make from confusing the phony target with a file name.
# In this case, if `test` folder exists, `make test` will still be run.
.PHONY: build run test down publish

test:
	@docker-compose run --rm tools -c "bats /test && \
		echo 'OK: Successfuly passed all the tests for this build of etcd...'"

build:
	@docker-compose build

# NOTE: Find out more about use of logical OR operators in bash:
# https://bash.cyberciti.biz/guide/Logical_OR
run:
	@docker-compose up -d && sleep 5 && \
		echo "OK: Successfuly launched all the required components..."

down:
	@docker-compose down && \
		echo "OK: Successfuly shutdown and removed all the required components..."

publish:
	@docker login -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}" && \
		docker-compose push etcd && \
		echo "OK: Successfuly published 'etcd' image..."