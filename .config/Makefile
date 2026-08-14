IMAGE_PREFIX ?= templates-tcc
MODEL ?= monografia
OUTPUT_NAME ?= main.pdf
ARTIFACT_DIR ?= artifacts
MODELS := monografia relatorio artigo apresentacao

.PHONY: FORCE images pdf presentation all monografia relatorio artigo apresentacao test validate-release clean

FORCE:

image-%: FORCE
	docker build --target $* --tag $(IMAGE_PREFIX):$* .

images: $(addprefix image-,$(MODELS))

pdf: image-$(MODEL)
	mkdir -p $(ARTIFACT_DIR)
	docker run --rm -e OUTPUT_NAME=$(OUTPUT_NAME) -v "$(CURDIR):/workspace:ro" -v "$(CURDIR)/$(ARTIFACT_DIR):/output" $(IMAGE_PREFIX):$(MODEL)

presentation: image-apresentacao
	mkdir -p $(ARTIFACT_DIR)
	docker run --rm -v "$(CURDIR):/workspace:ro" -v "$(CURDIR)/$(ARTIFACT_DIR):/output" $(IMAGE_PREFIX):apresentacao

monografia relatorio artigo:
	$(MAKE) -f .config/Makefile pdf MODEL=$@ OUTPUT_NAME=$@.pdf

apresentacao: presentation

all: pdf presentation

test:
	sh .config/scripts/test.sh $(ARTIFACT_DIR)

validate-release:
	sh .config/scripts/smoke-test.sh --no-cache

clean:
	rm -rf $(ARTIFACT_DIR)
