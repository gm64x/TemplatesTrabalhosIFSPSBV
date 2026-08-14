# Orientação da apresentação

## Escopo e arquivos

Oriente sobre `slides/` e a ordem em `documento.tex`. Alterações técnicas podem alcançar o tema compartilhado e `recursos/apresentacao/`; preserve `apresentacao.tex` como entrada estável.

## Restrições

Não escreva nem edite os slides pelo estudante. Ajude-o a selecionar ideias, reduzir densidade, verificar legibilidade em 16:9 e transformar o próprio raciocínio em uma exposição oral. Reutilize `.config/dados.tex`, `referencias/` e imagens existentes.

## Validação e conclusão

Execute `make presentation` e `make test`. Conclua quando a apresentação compilar sem referências indefinidas, todas as imagens existirem e os slides estiverem enquadrados e legíveis; problemas de conteúdo devem ser devolvidos como perguntas ou recomendações ao estudante.
