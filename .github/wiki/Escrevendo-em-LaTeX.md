O template separa o documento em arquivos pequenos. Comece configurando `.config/dados.tex`, escolhendo as opções em `.config/opcoes.tex` e escrevendo nos arquivos de `modelos/`. A entrada `main.tex` seleciona monografia, relatório ou artigo; `slide.tex` compila a apresentação. Veja também [Exemplos práticos](Exemplos-praticos) e [Referências bibliográficas](Referencias-bibliograficas).

## Estrutura de um texto

Nos modelos longos, use `\chapter` para capítulos e `\section`/`\subsection` para subdivisões. A monografia já inclui Introdução, Revisão da Literatura, Metodologia, Resultados e Discussão, Conclusões e Cronograma em [modelos/monografia/documento.tex](../../modelos/monografia/documento.tex). Um capítulo pode ser escrito assim:

```tex
\chapter{Introdução}
\label{cap:introducao}

Texto que apresenta o tema e os objetivos.

\section{Objetivos}
\subsection{Objetivo geral}
Descreva o objetivo geral.
```

Para citar outro ponto do documento, adicione `\label{...}` logo após o título, figura, quadro, tabela ou equação e use `\ref{...}`:

```tex
Como discutido no Capítulo~\ref{cap:introducao}, o projeto...
```

O `~` evita que o número fique separado do nome na quebra de linha. Não digite números manualmente: eles mudam quando o documento é reorganizado.

## Listas, destaque e texto literal

Use `itemize` para listas sem numeração e `enumerate` para passos ordenados. É possível aninhar listas:

```tex
\begin{itemize}
  \item Primeiro item;
  \item Segundo item;
  \begin{itemize}
    \item Subitem.
  \end{itemize}
\end{itemize}
```

Os exemplos do modelo usam `\textbf{negrito}`, `\textit{itálico}` e `\verb|comando|` para mostrar comandos no texto. Para um bloco literal curto, use `verbatim`. Para código salvo em arquivo, prefira `\lstinputlisting`, como em [02RevisaoLiteratura.tex](../../modelos/monografia/capitulos/02RevisaoLiteratura.tex):

```tex
\lstinputlisting[language=Java]{recursos/exemplos/ClasseExemplo.java}
```

O caminho é relativo à raiz do projeto, portanto mantenha o arquivo no local indicado ou ajuste o caminho.

## Figuras, tabelas e quadros

Os arquivos de exemplo [exemploFigura.png](../../recursos/exemplos/exemploFigura.png), [exemploQuadro.png](../../recursos/exemplos/exemploQuadro.png) e [ClasseExemplo.java](../../recursos/exemplos/ClasseExemplo.java) são usados pelos modelos. Uma figura segue este padrão:

```tex
\begin{figure}[!htbp]
  \centering
  \caption{Exemplo de figura}
  \includegraphics[scale=0.4]{recursos/exemplos/exemploFigura}
  \\\textbf{Fonte:} Elaborada pelo autor
  \label{fig:exemplo}
\end{figure}
```

Use `\ref{fig:exemplo}` no texto. Para tabela, troque o ambiente por `table` e use `tabular`; para um quadro, use o ambiente `quadro`. Os três exemplos completos estão em [02RevisaoLiteratura.tex](../../modelos/monografia/capitulos/02RevisaoLiteratura.tex). `\FloatBarrier` é usado no template para impedir que os objetos flutuantes atravessem uma seção.

## Equações

Equações numeradas usam `equation` e recebem uma etiqueta:

```tex
\begin{equation}
  x = y + z
  \label{eq:exemplo}
\end{equation}
```

No texto, escreva `Equação~\ref{eq:exemplo}`. Para fórmulas sem numeração, use `\[ ... \]`.

## Apêndices, anexos e cronograma

Na monografia, os arquivos [01Apendices.tex](../../modelos/monografia/postextuais/01Apendices.tex) e [02Anexos.tex](../../modelos/monografia/postextuais/02Anexos.tex) já fornecem os ambientes `apendicesenv` e `anexosenv`. Eles só entram no PDF quando `incluirApendices` ou `incluirAnexos` está habilitado em `.config/opcoes.tex`.

O capítulo de cronograma usa [cronograma.png](../../recursos/exemplos/cronograma.png), que pode ser atualizado a partir do modelo [templateCronograma.docx](../../recursos/exemplos/templateCronograma.docx). No modelo de graduação, ele é destinado à validação do projeto; na avaliação final, remova/desative esse capítulo conforme a orientação do próprio arquivo.

## Compilar e conferir

Para comandos de compilação e validação, consulte [README.md](../../README.md). O build usa `latexmk` e verifica se o PDF tem páginas e se não há referências ou citações indefinidas.
