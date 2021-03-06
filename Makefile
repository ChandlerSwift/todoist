.PHONY: install
install: prepare
	go install

.PHONY: build
build: prepare
	go build

.PHONY: test
test: prepare
	go test -v

.PHONY: prepare
prepare: filter_parser.go

filter_parser.go: filter_parser.y
	go get golang.org/x/tools/cmd/goyacc
	goyacc -o filter_parser.go filter_parser.y
	rm y.output

docker-build:
	docker build -t todoist --build-arg TODOIST_API_TOKEN=$(token) .

docker-run:
	docker run -it todoist /bin/bash
