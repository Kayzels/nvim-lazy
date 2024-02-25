local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local snippets = {
  s(
    {
      trig = "BENV",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{<>}
          <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1),
      }
    )
  ),
  s(
    {
      trig = "BANS",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{answer}
          <>
        \end{answer}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = "BDEF",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{definition}{<>}
          <>
        \end{definition}
      ]],
      {
        i(1, "title"),
        i(2),
      }
    )
  ),
  s(
    {
      trig = "BDES",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{description}
          \item[<>] <>
        \end{description}
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),
  s(
    {
      trig = "BDIT",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{descriptimize}
          \item[<>] <>
        \end{descriptimize}
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),
  s(
    {
      trig = "BDNM",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{descriptenum}
          \item[<>] <>
        \end{descriptenum}
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),
  s(
    {
      trig = "BNUM",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{enumerate}
          \item <>
        \end{enumerate}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = "BEXA",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{example}
          <>
        \end{example}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = "BEXT",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{example}[<>]
          <>
        \end{example}
      ]],
      {
        i(1, "title"),
        i(2),
      }
    )
  ),
  s(
    {
      trig = "BEXO",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{example}[<>][<>]
          <>
        \end{example}
      ]],
      {
        i(1, "title"),
        i(2, "options"),
        i(3),
      }
    )
  ),
  s(
    {
      trig = "BEXC",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{exercise}[<>]
          <>
        \end{exercise}
      ]],
      {
        i(1, "title"),
        i(2),
      }
    )
  ),
  s(
    {
      trig = "BINP",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{indentparagraph}
          <>
        \end{indentparagraph}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = "BIT",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{itemize}
          \item <>
        \end{itemize}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = "BQUE",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{question}
          <>
        \end{question}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = "BSDN",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{sidenote}{<>}
          <>
        \end{sidenote}
      ]],
      {
        i(1, "title"),
        i(2),
      }
    )
  ),
  s(
    {
      trig = "BTHM",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \begin{theorem}{<>}
          <>
        \end{theorem}
      ]],
      {
        i(1, "title"),
        i(2),
      }
    )
  ),
  s(
    {
      trig = "CNC",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \concept{<>}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    {
      trig = "NCHAP",
      snippetType = "autosnippet",
    },
    fmta(
      [[
        \providecommand{\main}{..}
        \documentclass[../notes.tex]{subfiles}

        \begin{document}
          \setcounter{chapter}{<>}
          \chapter{<>}
        \end{document}
      ]],
      {
        i(1, "number - 1"),
        i(2, "title"),
      }
    )
  ),
}

return snippets
