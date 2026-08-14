## Antes de investigar

Confirme que está na raiz do projeto e que o arquivo referenciado existe. Os comandos oficiais estão no [README.md](../../README.md). A compilação local exige `latexmk`; a compilação reproduzível usa Docker e o script [build.sh](../../.config/scripts/build.sh).

## Erros de compilação

**`File ... not found`** — confira o caminho relativo usado em `\input`, `\includegraphics` ou `\lstinputlisting`. Os caminhos do template partem da raiz, por exemplo `recursos/exemplos/exemploFigura`.

**Erro em `\cite` ou `undefined citation`** — a chave não existe ou está escrita diferente em [referencias.bib](../../recursos/referencias/referencias.bib). Corrija a chave e compile de novo para que o BibTeX seja executado.

**`undefined references`** — verifique se cada `\ref` possui um `\label` correspondente. Não altere o número manualmente. O build oficial considera esse caso falha: [build.sh](../../.config/scripts/build.sh) procura referências e citações indefinidas no log.

**LaTeX para em um erro de sintaxe** — procure chaves `{}` e ambientes `\begin{...}`/`\end{...}` sem par. Use `latexmk -pdf main.tex` para ver o erro localmente; o modo Docker usa `-halt-on-error`.

## PDF ausente ou inválido

Os comandos Docker gravam PDFs em `artifacts/`. O script de build cria um diretório temporário, valida que o PDF tem tamanho e páginas e copia o resultado para `/output`. Verifique se `artifacts/` existe e se o comando foi executado com o volume de saída correto.

Para validar artefatos já gerados:

```bash
make -f .config/Makefile test
```

Para recompilar todos os modelos e executar o smoke test Docker:

```bash
make -f .config/Makefile validate-release
```

No CI, os scripts `.config/scripts/*.sh` também são verificados com `sh -n`. Um PDF pode estar presente e ainda falhar se tiver zero páginas ou texto inconsistente na verificação de reprodutibilidade.

## Imagem, quadro ou cronograma não aparece

Use o nome sem extensão nas chamadas `\includegraphics`, como nos modelos, e confirme o arquivo em [recursos/exemplos](../../recursos/exemplos). Para o cronograma, substitua [cronograma.png](../../recursos/exemplos/cronograma.png), não o caminho no `.tex`. A imagem precisa estar no projeto quando o Docker é executado.

## Opção ou seção não aparece

Alguns elementos são condicionais: ficha catalográfica, ata, dedicatória, agradecimentos, epígrafe, apêndices e anexos dependem das opções em `.config/opcoes.tex`. A apresentação também inclui a seção de exemplos apenas quando `incluirExemplos` está habilitado. Confira o `\iftoggle` no documento do modelo antes de alterar o arquivo incluído.

## Docker não inicia

Confirme que o Docker está em execução e que a imagem foi construída a partir da raiz. O `Dockerfile` instala `latexmk`, BibTeX, fontes, `poppler-utils` e pacotes LaTeX necessários. Se a imagem estiver desatualizada após mudar `Dockerfile` ou `.config/scripts/build.sh`, reconstrua-a.
