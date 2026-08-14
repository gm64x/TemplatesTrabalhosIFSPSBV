Este repositório fornece modelos LaTeX baseados em abnTeX2 para monografia, relatório técnico, artigo e apresentação. O fluxo básico é: escolher o modelo, preencher os dados, editar o conteúdo e gerar o PDF.

## 1. Obtenha uma cópia do modelo

Clone o repositório ou baixe o arquivo desejado na página de [Releases](../releases). Os ZIPs são preparados para extração direta: crie uma pasta vazia para o trabalho e extraia nela o conteúdo do arquivo. `main.tex`, `.config/`, `recursos/` e as pastas do modelo ficarão diretamente na raiz, sem outra pasta `template-*` ou `modelos/<modelo>` por dentro.

Para trabalhar com Git:

```bash
git clone <URL_DO_REPOSITORIO>
cd templates-tcc
```

`<URL_DO_REPOSITORIO>` deve ser substituída pela URL exibida no botão **Code** do repositório. Em qualquer modo, não mova apenas um arquivo `.tex` para outra pasta.

## 2. Escolha o documento

Ao trabalhar no repositório clonado, abra [`.config/modelo.tex`](../../.config/modelo.tex). A macro `\ModeloDocumento` aceita exatamente `monografia`, `relatorio` ou `artigo`:

```tex
\def\ModeloDocumento{monografia}
```

No repositório, `main.tex` lê essa configuração e inclui `modelos/<modelo>/documento.tex`. Nos pacotes de release, o modelo já está selecionado e `documento.tex` fica na raiz; não é necessário mover arquivos nem trocar o modelo. A apresentação é independente: sua entrada é [`modelos/apresentacao/slide.tex`](../../modelos/apresentacao/slide.tex) e não depende do valor de `\ModeloDocumento`.

## 3. Preencha os dados

Edite [`.config/dados.tex`](../../.config/dados.tex), substituindo os valores de exemplo. Os campos principais são título, subtítulo, autor, orientador, curso, grau, área, câmpus, local, data e palavras-chave. O coorientador só aparece quando `\TCCCoorientador` não está vazio.

O artigo também usa os campos de formação e docência do orientador e do coorientador. Preencha-os quando o modelo selecionado for `artigo`.

## 4. Ajuste as opções

Em [`.config/opcoes.tex`](../../.config/opcoes.tex), cada elemento é controlado por `\toggletrue` ou `\togglefalse`. As opções começam habilitadas. Consulte [Configuração](Configuracao) antes de desativar fichas, ata ou anexos.

## 5. Escreva o trabalho

No repositório clonado, edite somente o modelo escolhido em `modelos/`:

- `modelos/monografia/`: capítulos, elementos pré-textuais, apêndices e anexos;
- `modelos/relatorio/`: capítulos e elementos pré-textuais;
- `modelos/artigo/`: seções do artigo;
- `modelos/apresentacao/slides/`: slides da apresentação.

Nos pacotes de release, essas pastas de conteúdo ficam na raiz:

- monografia: `capitulos/`, `pretextuais/` e `postextuais/`;
- relatório: `capitulos/` e `pretextuais/`;
- artigo: `secoes/`;
- apresentação: `slides/`;
- pacote com apresentação: conteúdo do documento na raiz e slides em `apresentacao/slides/`.

As referências compartilhadas ficam em [`recursos/referencias/referencias.bib`](../../recursos/referencias/referencias.bib). Imagens e documentos de apoio ficam em `recursos/`. Preserve os caminhos usados nos comandos `\input`, `\includegraphics` e `\includepdf`.

## Próximo passo

Veja [Configuração](Configuracao) para preencher cada campo e escolher opções; depois siga [Compilação](Compilacao) para gerar e validar os PDFs.
