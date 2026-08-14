# Templates TCC

Bem-vindo à documentação dos templates LaTeX para trabalhos acadêmicos do IFSP — Câmpus São João da Boa Vista. Os modelos são baseados em [abnTeX2](https://www.abntex.net.br/) e organizam a configuração, o texto e os recursos do trabalho em um fluxo único.

## Escolha um modelo

| O que você precisa entregar | Modelo/entrada | Onde começar |
| --- | --- | --- |
| Trabalho acadêmico completo, com capítulos, elementos pré-textuais e pós-textuais | **Monografia** | `modelos/monografia/` |
| Documento técnico organizado em introdução, metodologia, análise e recomendações | **Relatório técnico** | `modelos/relatorio/` |
| Texto acadêmico em formato mais enxuto, dividido em seções | **Artigo** | `modelos/artigo/` |
| Slides para apresentar o trabalho | **Apresentação** | `modelos/apresentacao/` e `slide.tex` |

Monografia, relatório e artigo são selecionados em `.config/modelo.tex`. A apresentação é uma entrada independente e não é selecionada nesse arquivo.

## Início rápido

1. Baixe o modelo desejado na página de [Releases](../releases) ou clone este repositório.
2. Para monografia, relatório ou artigo, selecione o valor correspondente (`monografia`, `relatorio` ou `artigo`) em `.config/modelo.tex`.
3. Preencha título, autoria, curso, orientação, local, data e palavras-chave em `.config/dados.tex`.
4. Ative ou desative elementos opcionais em `.config/opcoes.tex`.
5. Escreva nos arquivos da pasta do modelo escolhido em `modelos/`.
6. Compile o documento e confira o PDF gerado em `artifacts/`.

Para uma apresentação, edite os arquivos em `modelos/apresentacao/` e compile `slide.tex`.

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
