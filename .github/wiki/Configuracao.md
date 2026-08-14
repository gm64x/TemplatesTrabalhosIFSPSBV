# Configuração

As configurações compartilhadas ficam em `.config/`. Edite os arquivos de configuração antes de alterar os capítulos ou slides.

## Modelo do documento

Em [`.config/modelo.tex`](../../.config/modelo.tex), escolha uma destas três opções:

```tex
\def\ModeloDocumento{monografia}
\def\ModeloDocumento{relatorio}
\def\ModeloDocumento{artigo}
```

O valor selecionado é usado apenas quando `main.tex` é compilado. Não use `apresentacao` nesse arquivo: a apresentação é compilada a partir de `slide.tex`.

## Dados compartilhados

Em [`.config/dados.tex`](../../.config/dados.tex), substitua o texto de exemplo mantendo os nomes das macros. Os campos são:

| Macro | Uso |
| --- | --- |
| `TCCTitulo`, `TCCSubtitulo`, `TCCAutor` | identificação do trabalho e do autor |
| `TCCOrientador`, `TCCCoorientador` | identificação da orientação; deixe o coorientador vazio se não houver |
| `TCCCurso`, `TCCGrau`, `TCCArea` | curso, grau obtido e área de concentração |
| `TCCCampus`, `TCCLocal` | câmpus e local de apresentação |
| `TCCDia`, `TCCMes`, `TCCAno` | data exibida no documento |
| `TCCPalavrasChave` | palavras-chave separadas por ponto e vírgula |

As macros de graduação, pós-graduação e docência do orientador/coorientador são usadas na identificação dos autores do artigo. Não remova essas definições, mesmo que esteja usando outro modelo.

Use texto LaTeX válido nos valores. Caracteres reservados como `%`, `&`, `_`, `#` e `{` precisam ser escapados quando fizerem parte do texto (por exemplo, `\%` e `\&`).

## Elementos opcionais

Em [`.config/opcoes.tex`](../../.config/opcoes.tex), troque `\toggletrue` por `\togglefalse` para retirar um elemento:

| Toggle | Elemento controlado |
| --- | --- |
| `incluirFichaCatalografica` | ficha catalográfica de exemplo |
| `incluirAtaDefesa` | ata de defesa de exemplo |
| `incluirDedicatoria` | dedicatória (monografia) |
| `incluirAgradecimentos` | agradecimentos (monografia) |
| `incluirEpigrafe` | epígrafe (monografia) |
| `incluirApendices` | apêndices (monografia) |
| `incluirAnexos` | anexos (monografia) |
| `incluirExemplos` | exemplos de comandos; também inclui o slide `07Exemplos` |

Os arquivos `exemploFichaCatalografica.pdf` e `exemploAtaDefesa.pdf` são referências. Substitua-os pelos documentos finais nos caminhos correspondentes em `recursos/documentos/` antes da entrega.

## Conteúdo e referências

O ponto de entrada da monografia, relatório e artigo é [`main.tex`](../../main.tex). A apresentação usa [`slide.tex`](../../slide.tex), que carrega dados, opções, slides de `modelos/apresentacao/slides/` e as referências de [`recursos/referencias/referencias.bib`](../../recursos/referencias/referencias.bib).

Use os arquivos de modelo como ponto de partida e mantenha os caminhos relativos. Há exemplos de figuras, quadros, cronograma e código em [`recursos/exemplos/`](../../recursos/exemplos/).
