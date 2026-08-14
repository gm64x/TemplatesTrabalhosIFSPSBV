As referências são compartilhadas por monografia, relatório, artigo e apresentação. Edite apenas [recursos/referencias/referencias.bib](../../recursos/referencias/referencias.bib); os documentos já chamam esse arquivo com `\bibliography{recursos/referencias/referencias}`.

## Citar uma obra

Cada entrada possui uma chave única. No texto, use a chave entre chaves:

```tex
\cite{Agaisse1995}
```

Para citar mais de uma obra, separe as chaves por vírgula:

```tex
\cite{Abedi2014, Agaisse1995}
```

O template também demonstra a forma autor-data com `\citeauthorandyear{Agaisse1995}`. Para uma citação com página, informe a página como argumento opcional:

```tex
\cite[p. 81]{Nelson2014}
```

As chamadas reais estão em [02RevisaoLiteratura.tex](../../modelos/monografia/capitulos/02RevisaoLiteratura.tex) e nos exemplos da apresentação.

## Tipos disponíveis no arquivo

O `.bib` contém exemplos de:

- `@article`, como `Abedi2014`, com autor, título, periódico, volume, páginas e ano;
- `@book`, como `Nelson2014`, com editora, local, edição e páginas;
- `@misc`, como `BtNomenclature2016`, com URL e data de acesso.

Um registro novo deve ter pelo menos uma chave, autor, título e ano, além dos campos exigidos pelo tipo:

```bibtex
@book{MinhaChave2026,
  author    = {Sobrenome, Nome},
  title     = {{T}ítulo do livro},
  publisher = {Editora},
  address   = {Cidade},
  year      = {2026}
}
```

As chaves usadas em `\cite` precisam existir no `.bib`. Se uma obra não for citada, normalmente ela não aparece na lista gerada.

## Caracteres e acentuação

O arquivo usa chaves e campos BibTeX. Para preservar letras maiúsculas em títulos, o projeto envolve a letra com chaves, por exemplo `{{B}acillus}`. Mantenha esse padrão quando uma sigla ou nome próprio não deve ser convertido para minúsculas. Em nomes de autores, separe autores com `and`.

## Problemas comuns

Depois de alterar o `.bib`, compile novamente com `latexmk` (ou com o [build Docker](Compilacao)). O `latexmk` executa as passagens necessárias do LaTeX/BibTeX. Não copie a bibliografia gerada para dentro do projeto: ela é um artefato temporário.

Se aparecer `undefined citation`, confira a grafia da chave e se o arquivo está em `recursos/referencias/referencias.bib`. Se a lista não atualizar, remova apenas os arquivos auxiliares do diretório de saída ou deixe o `latexmk` refazer a compilação; consulte [Solução de problemas](Solucao-de-problemas).
