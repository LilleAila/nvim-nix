local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local ms = ls.multi_snippet

local helpers = require('luasnip_helpers.global')
local get_visual = helpers.get_visual
local nl_whitespace = helpers.nl_whitespace
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local tex_utils = require("luasnip_helpers.tex")

return {
	s({ trig = "doc", descr = "LaTeX document boilerplate" },
		fmta(
			[[
				\documentclass[10pt, preview, border=2cm]{standalone}
				\usepackage[a4paper, margin=2cm]{geometry}
				\usepackage[parfill]{parskip} % Better line breaks
				\usepackage{xcolor} % Colored text: \textcolor{color}{text}
				\usepackage{lmodern} % Change the font
				% \usepackage{multicol} % Add \begin{multicols}{} environment
				% \usepackage{lipsum} % Lorem Ipsum text: \lipsum[]

				\renewcommand{\contentsname}{Innhold} % Change table of contents title

				%%%%% Images
				\iffalse % This is a native way to use multiline comments
				\usepackage{graphicx} % Images
				\graphicspath{ {./images/} }
				\fi
				%%%%%

				%%%%% Math
				\usepackage{mathtools, amssymb, amsthm, amsmath, array, cancel} % Math
				\mathtoolsset{showonlyrefs}
				\setlength{\parindent}{0pt}
				%%%%%

				%%%%% Lists
				\usepackage{enumitem} % Custom lists
				\newcommand\Item[1][]{ % Add a custom list item that removes vertical space with math items
					% Use \Item instead of \item
					\ifx\relax#1\relax  \item \else \item[#1] \fi
					\abovedisplayskip=0pt\abovedisplayshortskip=0pt~\vspace*{-\baselineskip}}
				\renewcommand{\labelenumi}{\alph{enumi})}
				%%%%%

				%%%%% Custom title font sizes
				\usepackage{titlesec} % Changing title font size
				\titleformat*{\section}{\fontsize{14}{18}\selectfont}
				\titleformat*{\subsection}{\fontsize{10}{12}\selectfont}
				%%%%%

				%%%%%% Syntax highlighting with minted
				\iffalse
				% Add this to the beginning when using minted: %! TEX program = pdf_escaped
				\usepackage{minted, tcolorbox} % Code blocks and making them look good
				\definecolor{bg}{HTML}{282828}
				\usemintedstyle{monokai}
				\setminted{bgcolor=bg}
				\newtcolorbox{mintedbox}{
					arc=5mm,
					colframe = bg,
					colback = bg,
				}
				\fi
				%%%%%

				%%%%% Document commands
				\usepackage{xparse} % More advanced document commands
				%%%%%

				%%%%% Tikzpicture
				\iffalse
				\usepackage{tikz} % Tikzpicture to draw pictures
				\usetikzlibrary{calc, angles, quotes, arrows}
				\fi

				%%% Pgfplots for plotting graphs
				\iffalse
				\usepackage{pgfplots}
				\pgfplotsset{compat=1.18,width=10cm}
				\usepgfplotslibrary{external}
				\tikzexternalize
				\fi

				% \usepackage[siunitx]{circuitikz} % Circuit diagrams
				%%%%%

				%%%%% Links in \tableofcontents
				\iffalse
				\usepackage{hyperref}
				\hypersetup{
						colorlinks,
						citecolor=black,
						filecolor=black,
						linkcolor=black,
						urlcolor=black
				}
				\fi
				%%%%%

				%%%%% Document start
				\title{\vspace{-2cm}<>}
				\author{<>}
				\date{<>}

				\pagestyle{empty}
				\pagenumbering{gobble} % Remove page numbers
				\begin{document}

				% \maketitle

				<>

				\end{document}
			]],
			{ i(1, ""), i(2, ""), i(3, ""), i(4) }
		), { condition = line_begin }),

}
