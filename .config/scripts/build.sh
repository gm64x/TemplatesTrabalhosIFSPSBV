#!/bin/sh
set -eu

command_name="${1:-main}"
output_dir="${OUTPUT_DIR:-/output}"
model="${MODEL:-monografia}"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
mkdir -p "$output_dir"

export BIBINPUTS="/workspace:"
export BSTINPUTS="/workspace:"
validate_pdf() {
    pdf="$1"
    log="$2"
    pages="$(pdfinfo "$pdf" | awk '/^Pages:/ { print $2 }')"
    test -n "$pages" && test "$pages" -gt 0
    if grep -Eiq 'undefined (references|citations)|citation.*undefined|there were undefined references' "$log"; then
        echo "Undefined reference or citation found in $log" >&2
        exit 1
    fi
}

build_main() {
    output_name="${OUTPUT_NAME:-main.pdf}"
    latexmk -pdf \
        -pdflatex="pdflatex %O \"\\def\\ModeloDocumento{${model}}\\input{%S}\"" \
        -interaction=nonstopmode -halt-on-error \
        -outdir="$tmp_dir/main" main.tex
    test -s "$tmp_dir/main/main.pdf"
    validate_pdf "$tmp_dir/main/main.pdf" "$tmp_dir/main/main.log"
    cp "$tmp_dir/main/main.pdf" "$output_dir/$output_name"
}

build_presentation() {
    output_name="${OUTPUT_NAME:-apresentacao.pdf}"
    latexmk -pdf -interaction=nonstopmode -halt-on-error \
        -outdir="$tmp_dir/presentation" modelos/apresentacao/slide.tex
    test -s "$tmp_dir/presentation/slide.pdf"
    validate_pdf "$tmp_dir/presentation/slide.pdf" \
        "$tmp_dir/presentation/slide.log"
    cp "$tmp_dir/presentation/slide.pdf" "$output_dir/$output_name"
}

case "$command_name" in
    main) build_main ;;
    presentation) build_presentation ;;
    all)
        build_main
        build_presentation
        ;;
    *)
        echo "Usage: tcc-build {main|presentation|all}" >&2
        exit 2
        ;;
esac
