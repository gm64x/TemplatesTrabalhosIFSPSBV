Esta página reúne exemplos que já fazem parte dos modelos. Os trechos completos continuam sendo a referência principal; os links abaixo apontam para os arquivos do projeto.

## Figura

Em [02Desenvolvimento.tex](../../modelos/artigo/secoes/02Desenvolvimento.tex), a figura `recursos/exemplos/exemploFigura` é centralizada, recebe legenda, fonte e etiqueta:

```tex
\begin{figure}[!htbp]
  \centering
  \caption{Exemplo de figura}
  \includegraphics[scale=0.4]{recursos/exemplos/exemploFigura}
  \\\textbf{Fonte:} Elaborada pelo autor
  \label{fig:exemplo}
\end{figure}
```

No parágrafo, `Figura~\ref{fig:exemplo}` cria a referência cruzada. O arquivo de imagem correspondente é [exemploFigura.png](../../recursos/exemplos/exemploFigura.png).

## Tabela e quadro

Uma tabela simples usa `table` + `tabular`:

```tex
\begin{table}[!htbp]
  \centering
  \caption{Exemplo de tabela de 2 colunas}
  \begin{tabular}{ c | c }
    \textbf{Coluna 1} & \textbf{Coluna 2} \\\hline
    Valor 1 & Valor 2 \\
  \end{tabular}
  \\\textbf{Fonte:} Elaborada pelo autor
  \label{tab:exemplo}
\end{table}
```

Para o quadro demonstrado no template, use `\begin{quadro}` e inclua [exemploQuadro.png](../../recursos/exemplos/exemploQuadro.png). Consulte o arquivo de desenvolvimento para a sintaxe completa e faça a chamada como `Quadro~\ref{qua:exemplo}`.

## Equação e código

O exemplo de equação é numerado para permitir referência cruzada:

```tex
\begin{equation}
  x = y + z
  \label{eq:exemplo}
\end{equation}
```

Para código Java externo, [ClasseExemplo.java](../../recursos/exemplos/ClasseExemplo.java) é inserido assim:

```tex
\lstinputlisting[language=Java]{recursos/exemplos/ClasseExemplo.java}
```

Para texto curto digitado no próprio `.tex`, os modelos também mostram `verbatim`.

## Citações

As chaves abaixo existem no arquivo de bibliografia do projeto:

```tex
\cite{Abedi2014, Agaisse1995}
\citeauthorandyear{Nelson2014}
\cite[p. 81]{Nelson2014}
```

Veja [Referências bibliográficas](Referencias-bibliograficas) para criar entradas e [02RevisaoLiteratura.tex](../../modelos/monografia/capitulos/02RevisaoLiteratura.tex) para os exemplos em contexto.

## Cronograma

O cronograma é uma imagem incluída no capítulo/seção correspondente:

```tex
\includegraphics[scale=1]{recursos/exemplos/cronograma}
```

Atualize [cronograma.png](../../recursos/exemplos/cronograma.png), usando opcionalmente [templateCronograma.docx](../../recursos/exemplos/templateCronograma.docx). O modelo também lista as atividades com `enumerate`. O capítulo/seção é apropriado para a validação do projeto, não para a avaliação final.

## Apêndice e anexo

Habilite as opções e edite os arquivos [01Apendices.tex](../../modelos/monografia/postextuais/01Apendices.tex) e [02Anexos.tex](../../modelos/monografia/postextuais/02Anexos.tex). O primeiro é material elaborado pelo autor; o segundo é material não elaborado pelo autor usado como fundamentação, comprovação ou ilustração.
