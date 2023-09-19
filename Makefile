export DOCKER_BUILDKIT = 1
export CARGO_BUILD_RUSTFLAGS = -D warnings
export NEAR_RELEASE_BUILD = no
export CARGO_TARGET_DIR = target


# By default, build a regular release
all: release


docker-nearcore: DOCKER_TAG ?= nearcore
docker-nearcore:
	docker build -t $(DOCKER_TAG) -f Dockerfile --build-arg=make_target=busterd-release         --progress=plain .

docker-nearcore-sandbox: DOCKER_TAG ?= nearcore-sandbox
docker-nearcore-sandbox:
	docker build -t $(DOCKER_TAG) -f Dockerfile --build-arg=make_target=busterd-sandbox-release --progress=plain .

docker-nearcore-nightly: DOCKER_TAG ?= nearcore-nightly
docker-nearcore-nightly:
	docker build -t $(DOCKER_TAG) -f Dockerfile --build-arg=make_target=busterd-nightly-release --progress=plain .


release: busterd-release
	cargo build -p store-validator --release
	cargo build -p genesis-populate --release
	$(MAKE) sandbox-release

busterd: busterd-release
	@echo 'busterd binary ready in ./target/release/busterd'

busterd-release: NEAR_RELEASE_BUILD=release
busterd-release:
	cargo build -p busterd --release

busterd-debug:
	cargo build -p busterd

debug: busterd-debug
	cargo build -p store-validator
	cargo build -p genesis-populate
	$(MAKE) sandbox


perf-release: NEAR_RELEASE_BUILD=release
perf-release:
	CARGO_PROFILE_RELEASE_DEBUG=true cargo build -p busterd --release --features performance_stats
	cargo build -p store-validator --release --features nearcore/performance_stats


perf-debug:
	cargo build -p busterd --features performance_stats
	cargo build -p store-validator --features nearcore/performance_stats


nightly-release: busterd-nightly-release
	cargo build -p store-validator --release --features nearcore/nightly,nearcore/performance_stats
	cargo build -p genesis-populate --release --features nearcore/nightly,nearcore/performance_stats

busterd-nightly-release:
	cargo build -p busterd --release --features nightly,performance_stats


nightly-debug:
	cargo build -p busterd --features nightly,performance_stats
	cargo build -p store-validator --features nearcore/nightly,nearcore/performance_stats
	cargo build -p genesis-populate --features nearcore/nightly,nearcore/performance_stats


assertions-release: NEAR_RELEASE_BUILD=release
assertions-release:
	CARGO_PROFILE_RELEASE_DEBUG=true CARGO_PROFILE_RELEASE_DEBUG_ASSERTIONS=true cargo build -p busterd --release --features performance_stats

sandbox: CARGO_TARGET_DIR=sandbox
sandbox: busterd-sandbox
	mkdir -p target/debug
	ln -f sandbox/debug/busterd target/debug/busterd-sandbox
	@ln -f sandbox/debug/busterd target/debug/near-sandbox

busterd-sandbox:
	cargo build -p busterd --features sandbox


sandbox-release: CARGO_TARGET_DIR=sandbox
sandbox-release: busterd-sandbox-release
	mkdir -p target/release
	ln -f sandbox/release/busterd target/release/busterd-sandbox
	@ln -f sandbox/release/busterd target/release/near-sandbox

busterd-sandbox-release:
	cargo build -p busterd --features sandbox --release


.PHONY: docker-nearcore docker-nearcore-nightly release busterd debug
.PHONY: perf-release perf-debug nightly-release nightly-debug assertions-release sandbox
.PHONY: sandbox-release
