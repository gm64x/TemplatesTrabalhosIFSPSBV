![Instituto Federal de São Paulo — Câmpus São João da Boa Vista](recursos/apresentacao/logo.png)

# Templates TCC

Templates LaTeX para trabalhos acadêmicos do IFSP — Câmpus São João da Boa Vista, baseados em abnTeX2.

## Modelos

- Monografia
- Relatório técnico
- Artigo
- Apresentação

> [!TIP]
> Para começar rapidamente, baixe apenas o modelo desejado na página de [Releases](../../releases).

## Primeiros passos

1. Selecione `monografia`, `relatorio` ou `artigo` em `.config/modelo.tex`.
2. Preencha os dados do trabalho em `.config/dados.tex`.
3. Ajuste os elementos opcionais em `.config/opcoes.tex`.
4. Escreva nas pastas correspondentes em `modelos/`.

A apresentação usa a entrada independente `slide.tex`. As referências compartilhadas ficam em `recursos/referencias/referencias.bib`.

## Estrutura

```text
main.tex                 documento selecionado
slide.tex                apresentação
.config/                 dados, opções, Makefile, scripts e estilos
modelos/                 monografia, relatório, artigo e slides
recursos/                 imagens, documentos, exemplos e referências
```

## Compilação

### Docker e Make

```bash
make -f .config/Makefile monografia
make -f .config/Makefile relatorio
make -f .config/Makefile artigo
make -f .config/Makefile apresentacao
```

Os PDFs são gravados em `artifacts/`.

### Ambiente LaTeX local

```bash
latexmk -pdf main.tex
latexmk -pdf slide.tex
```

## Validação

```bash
make -f .config/Makefile test
make -f .config/Makefile validate-release
```

O primeiro comando valida artefatos existentes. O segundo recompila e verifica todos os modelos em Docker.

> [!NOTE]
> `word-legado.zip` contém os antigos modelos do Microsoft Word apenas para consulta histórica.
