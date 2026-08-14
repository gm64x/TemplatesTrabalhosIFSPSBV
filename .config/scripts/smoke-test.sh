#!/bin/sh
set -eu

image_prefix="${IMAGE_PREFIX:-templates-tcc}"
artifacts="${ARTIFACT_DIR:-artifacts}"
no_cache="${1:-}"

rm -rf "$artifacts"
mkdir -p "$artifacts/reproducibility"

build_image() {
    model="$1"
    if [ "$no_cache" = "--no-cache" ]; then
        docker build --no-cache --target "$model" --tag "$image_prefix:$model" .
    else
        docker build --target "$model" --tag "$image_prefix:$model" .
    fi
}

for model in monografia relatorio artigo apresentacao; do
    build_image "$model"
done

host_workspace="$(pwd -W 2>/dev/null || pwd)"
host_artifacts="$(cd "$artifacts" && (pwd -W 2>/dev/null || pwd))"
source_mount="$host_workspace:/workspace:ro"
output_mount="$host_artifacts:/output"
repro_mount="$host_artifacts/reproducibility:/output"

for model in monografia relatorio artigo; do
    MSYS_NO_PATHCONV=1 docker run --rm \
        --env OUTPUT_NAME="$model.pdf" \
        --volume "$source_mount" --volume "$output_mount" \
        "$image_prefix:$model"
done

MSYS_NO_PATHCONV=1 docker run --rm \
    --volume "$source_mount" --volume "$output_mount" \
    "$image_prefix:apresentacao"

MSYS_NO_PATHCONV=1 docker run --rm --env OUTPUT_NAME=monografia.pdf \
    --volume "$source_mount" --volume "$repro_mount" \
    "$image_prefix:monografia"
MSYS_NO_PATHCONV=1 docker run --rm \
    --volume "$source_mount" --volume "$repro_mount" \
    "$image_prefix:apresentacao"

MSYS_NO_PATHCONV=1 docker run --rm --entrypoint sh \
    --volume "$output_mount" "$image_prefix:monografia" -c '
      for artifact in monografia.pdf apresentacao.pdf; do
        test "$(pdfinfo "/output/$artifact" | awk "/^Pages:/ { print \$2 }")" = \
             "$(pdfinfo "/output/reproducibility/$artifact" | awk "/^Pages:/ { print \$2 }")"
        pdftotext "/output/$artifact" "/tmp/$artifact.first.txt"
        pdftotext "/output/reproducibility/$artifact" "/tmp/$artifact.second.txt"
        cmp "/tmp/$artifact.first.txt" "/tmp/$artifact.second.txt"
      done
    '

EXPECTED_ARTIFACTS="monografia.pdf relatorio.pdf artigo.pdf apresentacao.pdf" \
    .config/scripts/test.sh "$artifacts"
