PREFIX=docker-machine-driver-kvm
MACHINE_VERSION=v0.10.0
GO_VERSION=1.13.15
DESCRIBE=$(shell git describe --tags)

TARGETS=$(PREFIX)

build: $(TARGETS)

docker-machine-driver-build: Dockerfile
	docker build --build-arg "MACHINE_VERSION=$(MACHINE_VERSION)" --build-arg "GO_VERSION=$(GO_VERSION)" -t $@ -f $< .

docker-machine-driver-kvm: docker-machine-driver-build
	docker run --rm -w /app -v $(PWD):/app -v $(GOPATH):/go $< go build -v ./cmd/docker-machine-driver-kvm

clean:
	rm -f ./$(PREFIX)*

release: build
	@echo "Paste the following into the release page on github and upload the binaries..."
	@echo ""
	@for bin in $(PREFIX)* ; do \
	    target=$$(echo $${bin} | cut -f5- -d-) ; \
	    md5=$$(md5sum $${bin}) ; \
	    echo "* $${target} - md5: $${md5}" ; \
	    echo '```' ; \
	    echo "  curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/$(DESCRIBE)/$${bin} > /usr/local/bin/$(PREFIX) \\ " ; \
	    echo "  chmod +x /usr/local/bin/$(PREFIX)" ; \
	    echo '```' ; \
	done

