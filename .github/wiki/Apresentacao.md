A apresentação é um projeto Beamer independente dos modelos de monografia, relatório e artigo. O ponto de entrada é [`slide.tex`](../../slide.tex), que carrega [`modelos/apresentacao/documento.tex`](../../modelos/apresentacao/documento.tex).

## Preencher os dados

Edite [`.config/dados.tex`](../../.config/dados.tex). A apresentação usa título, subtítulo, autor, orientador, coorientador, curso, local, dia, mês e ano. Ela também compartilha `.config/opcoes.tex` e a bibliografia em `recursos/referencias/referencias.bib`.

## Editar os slides

Os slides principais estão em [`modelos/apresentacao/slides/`](../../modelos/apresentacao/slides/):

- `01Capa.tex`: capa e agenda;
- `02Introducao.tex`: introdução e objetivos;
- `03RevisaoLiteraturaConsideracoesGerais.tex`: revisão da literatura/considerações gerais;
- `04Metodologia.tex`: metodologia;
- `05Resultados.tex`: resultados;
- `06Conclusao.tex`: conclusão, trabalhos futuros e encerramento;
- `00Referencias.tex`: slide final de referências; mantenha-o no fluxo;
- `07Exemplos.tex`: exemplos de LaTeX, incluídos somente quando `incluirExemplos` está ativo.

Substitua os textos de exemplo em `02` a `06`. Para acrescentar ou remover slides, edite esses arquivos mantendo ambientes `frame`, `section` e `subsection` válidos. A classe usa proporção widescreen (`aspectratio=169`) e o estilo em `.config/tex/estrutura/apresentacao.sty`.

## Imagens, código e referências

Mantenha imagens em `recursos/` e use o caminho relativo a partir da raiz, como nos exemplos. O slide de referências lê `recursos/referencias/referencias.bib`; toda chave usada em `\cite` precisa existir nesse arquivo.

## Gerar o PDF

Com Docker e Make:

```bash
make -f .config/Makefile apresentacao
```

O resultado esperado é `artifacts/apresentacao.pdf`. Também é possível compilar localmente:

```bash
latexmk -pdf slide.tex
```

Para verificar o PDF e testar a compilação reproduzível junto com os demais modelos:

```bash
make -f .config/Makefile validate-release
```

Se `incluirExemplos` estiver como `\toggletrue`, o PDF conterá o slide `07Exemplos`; troque para `\togglefalse` na versão final. Erros de referências/citações indefinidas fazem a compilação Docker falhar e devem ser corrigidos no `.bib` ou no comando `\cite`.
