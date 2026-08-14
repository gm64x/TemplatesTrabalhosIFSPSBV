Há dois modos suportados: Docker com Make (recomendado para reproduzir o ambiente do projeto) e uma instalação LaTeX local.

## Docker e Make

É necessário ter Docker e GNU Make disponíveis no terminal. Na raiz do repositório, execute:

```bash
make -f .config/Makefile monografia
make -f .config/Makefile relatorio
make -f .config/Makefile artigo
make -f .config/Makefile apresentacao
```

Os três primeiros alvos compilam `main.tex` com o modelo correspondente. O alvo `apresentacao` compila `slide.tex`. Cada comando constrói a imagem Docker necessária, executa o compilador em um diretório temporário e grava o PDF em `artifacts/` (`monografia.pdf`, `relatorio.pdf`, `artigo.pdf` ou `apresentacao.pdf`).

Para compilar um modelo por variável, use o alvo `pdf` (o padrão é `monografia`):

```bash
make -f .config/Makefile pdf
```

O nome padrão será `artifacts/main.pdf`. Para escolher outro modelo e definir o nome:

```bash
make -f .config/Makefile pdf MODEL=monografia OUTPUT_NAME=monografia.pdf
```

Para compilar o documento e a apresentação:

```bash
make -f .config/Makefile all
```

## Ambiente LaTeX local

Com `latexmk` e as dependências LaTeX instaladas, execute na raiz:

```bash
latexmk -pdf main.tex
latexmk -pdf slide.tex
```

O primeiro usa o valor de [`.config/modelo.tex`](../../.config/modelo.tex); o segundo gera `slide.pdf`. Nesse modo os arquivos ficam no diretório de trabalho, não em `artifacts/`.

## Validação

Depois de gerar os PDFs, confira se existem e possuem páginas:

```bash
make -f .config/Makefile test
```

Esse alvo valida os artefatos esperados (por padrão `main.pdf` e `apresentacao.pdf`). Quando os alvos nomeados foram usados, valide explicitamente todos:

```bash
EXPECTED_ARTIFACTS="monografia.pdf relatorio.pdf artigo.pdf apresentacao.pdf" sh .config/scripts/test.sh artifacts
```

Para reconstruir as quatro imagens sem cache, executar o smoke test e verificar a reprodutibilidade:

```bash
make -f .config/Makefile validate-release
```

O script `smoke-test.sh --no-cache` remove e recria `artifacts/`, compila os quatro modelos, verifica PDFs e compara uma segunda compilação. O comando exige Docker e deve ser executado na raiz do repositório.

## Problemas comuns

- **PDF desatualizado:** confirme que está executando o comando na raiz e que editou o arquivo do modelo selecionado.
- **Erro de arquivo ausente:** preserve a estrutura extraída. No repositório, o conteúdo fica em `modelos/`; nos pacotes de release, as pastas do modelo ficam na raiz. Em ambos os casos, os caminhos para `.config/` e `recursos/` são relativos.
- **Referência ou citação indefinida no Docker:** o script interrompe a compilação quando o log contém referências ou citações indefinidas; confira a chave usada no `.bib` e compile novamente.
- **Falha de dependência local:** use Docker ou instale as dependências listadas no [`Dockerfile`](../../Dockerfile).
