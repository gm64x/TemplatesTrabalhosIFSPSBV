# Templates de trabalhos acadêmicos do IFSP-SBV

Templates em LaTeX para trabalhos de conclusão de curso do Instituto Federal de
Educação, Ciência e Tecnologia de São Paulo — Câmpus São João da Boa Vista.

Modelos disponíveis:

- monografia;
- relatório técnico;
- artigo;
- apresentação.

Os templates utilizam `abnTeX2` e foram desenvolvidos pelo Prof. Dr. David
Buzatto. Os modelos do Microsoft Word foram descontinuados e permanecem apenas
como material histórico em `word-legado.zip`.

## Como começar

### Baixar somente o modelo necessário

O caminho recomendado para alunos é baixar um pacote na página de
[Releases](../../releases):

- `template-monografia.zip`;
- `template-relatorio.zip`;
- `template-artigo.zip`;
- `template-apresentacao.zip`;
- `template-monografia-com-apresentacao.zip`;
- `template-relatorio-com-apresentacao.zip`;
- `template-artigo-com-apresentacao.zip`.

Cada pacote contém apenas o documento escolhido, suas configurações e os
recursos necessários. Os pacotes com apresentação compartilham os dados do
trabalho, as referências e as imagens entre os dois documentos.

### Clonar o repositório completo

Quem deseja acessar todos os modelos ou contribuir pode clonar o repositório:

```bash
git clone URL_DO_REPOSITORIO meu-tcc
cd meu-tcc
```

Selecione em `.config/modelo.tex` qual documento será compilado por `main.tex`:

```latex
\def\ModeloDocumento{monografia}
```

Valores disponíveis:

```text
monografia
relatorio
artigo
```

A apresentação possui uma entrada independente, `apresentacao.tex`, porque usa
a classe `beamer` e normalmente acompanha o trabalho em vez de substituí-lo.

## Configuração

Preencha os dados do trabalho em:

```text
.config/dados.tex
```

Esse arquivo é compartilhado pelo documento e pela apresentação. Nele ficam,
entre outros:

- título e subtítulo;
- autor;
- orientador e coorientador;
- curso e grau;
- área de concentração;
- câmpus e local;
- data;
- palavras-chave;
- dados adicionais dos autores exigidos pelo artigo.

Elementos opcionais são controlados em:

```text
.config/opcoes.tex
```

Use `\toggletrue` para incluir e `\togglefalse` para omitir um elemento:

```latex
\toggletrue{incluirFichaCatalografica}
\togglefalse{incluirDedicatoria}
\toggletrue{incluirAgradecimentos}
```

## Onde escrever

### Monografia

```text
modelos/monografia/pretextuais/
modelos/monografia/capitulos/
modelos/monografia/postextuais/
```

### Relatório técnico

```text
modelos/relatorio/pretextuais/
modelos/relatorio/capitulos/
```

### Artigo

```text
modelos/artigo/secoes/
```

### Apresentação

```text
modelos/apresentacao/slides/
```

Os arquivos seguem o mesmo padrão de nomes usado no projeto `tex-guy`, como
`pretextuais/01Capa.tex`, `capitulos/01Introducao.tex` e
`slides/02Introducao.tex`.

## Recursos

```text
recursos/
├── apresentacao/   capa e identidade visual dos slides
├── documentos/    ficha catalográfica e ata de defesa
└── exemplos/      figuras, códigos e cronograma demonstrativos
```

Coloque imagens e códigos reais do trabalho em novos subdiretórios de
`recursos/`. O conteúdo de `recursos/exemplos/` pode ser removido depois que as
seções demonstrativas correspondentes deixarem de ser utilizadas.

As referências bibliográficas ficam em:

```text
referencias/referencias.bib
```

Ao receber a ficha catalográfica e a ata oficiais, substitua os exemplos sem
alterar seus caminhos:

```text
recursos/documentos/exemploFichaCatalografica.pdf
recursos/documentos/exemploAtaDefesa.pdf
```

## Compilação

### Ambiente local

Com `latexmk`, TeX Live e os pacotes usados pelo template instalados:

```bash
latexmk -pdf main.tex
latexmk -pdf apresentacao.tex
```

Ao trocar o modelo em `.config/modelo.tex`, limpe os auxiliares antes de
recompilar:

```bash
latexmk -C main.tex
latexmk -pdf main.tex
```


### Docker e Make

Um único `Dockerfile` fornece quatro imagens independentes, com o modelo correto
como comando padrão. A base TeX é compartilhada para evitar duplicação:

```bash
make monografia
make relatorio
make artigo
make apresentacao
make images
```

`make pdf` gera `main.pdf` para `MODEL=monografia` por padrão; `make all` gera o
documento selecionado e a apresentação. O código-fonte entra como volume
somente leitura e os resultados saem em `artifacts/`.

Para construir e usar uma imagem diretamente:

```bash
docker build --target artigo -t templates-tcc:artigo .
docker run --rm \
  -v "$PWD:/workspace:ro" -v "$PWD/artifacts:/output" \
  templates-tcc:artigo
```

Use `make test` para validar PDFs existentes e `make validate-release` para a
homologação limpa das quatro imagens. `artifacts/` contém somente saídas
derivadas e distribuíveis; as fontes LaTeX são canônicas e o diretório não é
versionado.

## Imagens no GHCR

Após `validate-release`, mudanças no ambiente ou tags `v*` publicam os quatro
alvos em `ghcr.io/OWNER/REPOSITORY`. Cada modelo recebe tags próprias:

- `<modelo>-latest` no branch padrão;
- `<modelo>-sha-<commit>`;
- `<modelo>-v1.2.3` em uma tag de release;
- `latest` como atalho para `monografia-latest`.

```bash
docker pull ghcr.io/OWNER/REPOSITORY:artigo-latest
docker run --rm \
  -v "$PWD:/workspace:ro" -v "$PWD/artifacts:/output" \
  ghcr.io/OWNER/REPOSITORY:artigo-latest
```

Pull requests, inclusive de forks, apenas validam: não autenticam no GHCR, não
publicam pacotes e não recebem secrets. Publicação em `main` e tags ocorre em
jobs separados, com permissões de escrita limitadas ao job necessário.

## CI e validação de release

`dorny/paths-filter` encerra o trabalho antes dos jobs caros quando a mudança
não afeta documentos, testes ou Docker. Em pull requests, cada alvo possui um
hash próprio: monografia, relatório, artigo, apresentação e dependências do
ambiente são invalidados apenas pelas fontes que realmente usam. O cache
reduz reconstruções, mas um cache hit ainda consome o runner de validação.

Não há métrica de code coverage porque o repositório não contém código que
possa ser testado por unidade. A automação usa validação de build, testes
estruturais e smoke tests dos artefatos.

O job `validate-release` roda em checkout novo, sem cache Docker, em `main`,
tags `v*` ou execução manual. Ele é a barreira obrigatória anterior a GHCR,
Overleaf e GitHub Release.

| Verificação | Método | Sucesso | Falha |
|---|---|---|---|
| Docker | quatro alvos com `docker build --no-cache` e base fixada | imagens criadas | erro de build ou dependência |
| PDFs | `latexmk` e `pdfinfo` | arquivos não vazios com páginas | erro fatal, zero páginas ou formato inválido |
| Referências e citações | inspeção do log final do LaTeX | nenhuma referência/citação indefinida | aviso indefinido |
| Apresentação | compilação e validação PDF | PDF não vazio com páginas | erro LaTeX ou PDF inválido |
| Reprodutibilidade | segunda geração, paginação e texto extraído | mesmo conteúdo | conteúdo ou páginas diferentes |
| Matriz | monografia, relatório, artigo e apresentação | quatro artefatos válidos | qualquer alvo ausente ou inválido |

Execute a homologação local com:

```bash
.config/scripts/smoke-test.sh --no-cache
```

Os candidatos validados são armazenados por GitHub Actions. Uma tag `v*` usa
esses mesmos arquivos para a Release, sem versioná-los como fonte.

## Sincronização opcional com Overleaf

A sincronização só é tentada após `validate-release` em `main` ou `master`. Sem
configuração, o job informa que a integração foi ignorada e não afeta o sucesso
do CI. Configure em **Settings > Secrets and variables > Actions**:

- `OVERLEAF_PROJECT_ID`: identificador do projeto;
- `OVERLEAF_GIT_TOKEN`: token Git fornecido pelo Overleaf.

A integração Git não existe em todos os planos ou projetos Overleaf. O GitHub é
a fonte de verdade: o job faz `push --force` do commit validado para `master`,
então edições feitas apenas no editor web podem ser sobrescritas. Se o plano,
o projeto ou as credenciais não permitirem Git, mantenha a sincronização
desconfigurada. Nenhum envio ocorre quando `validate-release` falha.

## Arquitetura de agentes

As regras gerais ficam em `.agents/AGENTS.md`; cada modelo possui orientações
específicas em `modelos/<modelo>/.agents/AGENTS.md`, sem cópias idênticas. O
agente pode manter infraestrutura técnica, mas apenas orienta o estudante sobre
o texto acadêmico. Preferências locais ficam em `.agents/memo.md`, ignorado pelo
Git; `.agents/memo.example.md` documenta somente campos não sensíveis.

## Organização e migração

```text
main.tex                       entrada do documento selecionado
apresentacao.tex               entrada independente dos slides
Dockerfile                     quatro imagens, sem artefatos embutidos
.agents/                       regras e exemplo de preferências
.config/                       dados, opções, estilos e scripts técnicos
modelos/                       conteúdo e regras de cada modelo
recursos/                      imagens, códigos e documentos
referencias/                   base bibliográfica compartilhada
.github/workflows/ci.yml       PR, validate-release e publicações
```

A consolidação preserva todas as fontes e dependências usadas pelos quatro
modelos. Antes da remoção de `Arquivo/`, seu RAR e o ZIP interno foram testados:
os arquivos duplicados foram descartados e os seis modelos Word, o estilo
bibliográfico, o instalador e as três pré-visualizações únicas foram reunidos em
`word-legado.zip`. Os PDFs LaTeX reproduzíveis da raiz passaram a ser distribuídos
por Actions e Releases. As mudanças de infraestrutura permanecem isoladas do
conteúdo acadêmico para reduzir conflitos quando forks mesclarem `upstream`.
