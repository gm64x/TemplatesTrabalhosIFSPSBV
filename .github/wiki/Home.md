Bem-vindo à documentação dos templates LaTeX para trabalhos acadêmicos do IFSP — Câmpus São João da Boa Vista. Os modelos são baseados em [abnTeX2](https://www.abntex.net.br/) e organizam a configuração, o texto e os recursos do trabalho em um fluxo único.

## Escolha um modelo

| O que você precisa entregar | Modelo | No repositório | No pacote da release |
| --- | --- | --- | --- |
| Trabalho acadêmico completo, com capítulos, elementos pré-textuais e pós-textuais | **Monografia** | `modelos/monografia/` | `capitulos/`, `pretextuais/` e `postextuais/` |
| Documento técnico organizado em introdução, metodologia, análise e recomendações | **Relatório técnico** | `modelos/relatorio/` | `capitulos/` e `pretextuais/` |
| Texto acadêmico em formato mais enxuto, dividido em seções | **Artigo** | `modelos/artigo/` | `secoes/` |
| Slides para apresentar o trabalho | **Apresentação** | `modelos/apresentacao/` | `slides/` e `slide.tex` |

Monografia, relatório e artigo são selecionados em `.config/modelo.tex`. A apresentação é uma entrada independente e não é selecionada nesse arquivo.

## Início rápido

1. Baixe o modelo desejado na página de [Releases](../releases) ou clone este repositório.
2. Se baixou um ZIP, extraia-o em uma pasta vazia. `main.tex`, `.config/`, `recursos/` e as pastas de conteúdo ficam diretamente nessa raiz, sem uma pasta `modelos/` intermediária.
3. Se clonou o repositório, selecione `monografia`, `relatorio` ou `artigo` em `.config/modelo.tex` e edite o conteúdo em `modelos/<modelo>/`.
4. Preencha título, autoria, curso, orientação, local, data e palavras-chave em `.config/dados.tex`.
5. Ative ou desative elementos opcionais em `.config/opcoes.tex`.
6. Compile o documento e confira o PDF gerado em `artifacts/`.

Na release exclusiva de apresentação, edite `slides/` e compile `slide.tex`. No repositório, os mesmos arquivos ficam em `modelos/apresentacao/`.

## Compilação rápida

Com Docker e Make, na raiz do repositório:

```bash
make -f .config/Makefile monografia
make -f .config/Makefile relatorio
make -f .config/Makefile artigo
make -f .config/Makefile apresentacao
```

Em um ambiente LaTeX local, também é possível usar:

```bash
latexmk -pdf main.tex
latexmk -pdf slide.tex
```

Os PDFs são gravados em `artifacts/`. Para validar artefatos existentes ou verificar todos os modelos em Docker:

```bash
make -f .config/Makefile test
make -f .config/Makefile validate-release
```

## Navegação

Consulte a barra lateral para seguir o fluxo completo: configuração, compilação, escrita em LaTeX, referências bibliográficas, apresentação, exemplos e solução de problemas. A página [Primeiros passos](Primeiros-passos) resume a preparação inicial; [Configuração](Configuracao) documenta os arquivos em `.config/`.

As referências compartilhadas ficam em `recursos/referencias/referencias.bib`. O arquivo `word-legado.zip` é mantido apenas para consulta histórica.
