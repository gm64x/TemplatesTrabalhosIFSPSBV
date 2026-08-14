# Orientação da monografia

## Escopo e arquivos

Oriente sobre `pretextuais/`, `capitulos/` e `postextuais/`; mantenha a ordem ABNT em `documento.tex`. Use `.config/opcoes.tex` para ficha, ata, dedicatória, apêndices e anexos, sem remover suas entradas.

## Restrições

Não escreva nem edite a monografia pelo estudante. Ajude-o a formular perguntas, avaliar a argumentação, localizar lacunas e revisar o próprio texto. Preserve `\chapter`, rótulos descritivos e referências cruzadas.

## Validação e conclusão

Execute `make -f .config/Makefile pdf MODEL=monografia` e `make -f .config/Makefile test`. Conclua quando o PDF compilar sem referências ou citações indefinidas e sumário, listas, bibliografia e paginação estiverem íntegros; revisões acadêmicas devem permanecer sob autoria do estudante.
