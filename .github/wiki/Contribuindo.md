# Contribuindo

Contribuições devem manter os modelos compiláveis e preservar a separação entre configuração, modelos, recursos e scripts. Antes de propor uma mudança, leia o [README.md](../../README.md) e identifique qual modelo ela afeta: monografia, relatório, artigo ou apresentação.

## Fluxo recomendado

1. Crie uma branch para a mudança.
2. Edite o arquivo específico em `modelos/`, `.config/` ou `recursos/`.
3. Se a mudança for de conteúdo, confira também os caminhos `\input`, imagens e referências compartilhadas.
4. Rode a validação local:

   ```bash
   make -f .config/Makefile test
   make -f .config/Makefile validate-release
   ```

5. Revise o diff e abra um pull request descrevendo modelos afetados, arquivos alterados e comandos executados.

## O que validar

- scripts shell: `sh -n .config/scripts/*.sh`;
- PDFs com páginas e sem referências/citações indefinidas;
- caminhos de imagens, código, documentos e `referencias.bib`;
- opções condicionais em `.config/opcoes.tex`;
- compilação dos quatro alvos: monografia, relatório, artigo e apresentação.

O CI aplica filtros por tipo de mudança e executa os testes relevantes. Mudanças em `.tex`, `.bib`, `recursos/`, `Dockerfile` ou `build.sh` entram na validação documental; mudanças nos scripts entram na validação dos testes.

## Conteúdo e exemplos

Prefira exemplos que possam ser compilados e mantenha os arquivos de apoio junto ao caminho usado no `.tex`. Para alterar uma citação, atualize [recursos/referencias/referencias.bib](../../recursos/referencias/referencias.bib). Para alterar uma figura ou o cronograma, atualize os arquivos em [recursos/exemplos](../../recursos/exemplos).

Não inclua PDFs gerados ou arquivos temporários no commit. Os artefatos são produzidos em `artifacts/` durante a validação e nas releases.

## Alterações na Wiki

As páginas fonte ficam em `.github/wiki/`. O workflow [publish-wiki.yml](../workflows/publish-wiki.yml) publica alterações feitas nessa pasta na GitHub Wiki quando entram na branch `master`; ele também pode ser executado manualmente. Use Markdown compatível com GitHub Wiki e links relativos entre páginas, como `[Solução de problemas](Solucao-de-problemas)`.

### Primeira publicação

Antes da primeira execução, habilite **Wikis** em **Settings → General → Features** e crie manualmente uma página temporária na aba **Wiki**. Essa etapa inicializa o repositório `<projeto>.wiki.git` exigido pelo GitHub. Depois disso, execute o workflow manualmente em **Actions → Publish wiki → Run workflow**; a página temporária será substituída pelo conteúdo versionado.

Ao adicionar uma página, mantenha o nome simples (sem espaços quando possível), inclua links para as páginas relacionadas e confirme que os links para arquivos do repositório apontam para a raiz com `../../`.
