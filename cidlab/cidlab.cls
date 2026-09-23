% Modern LaTeX document class for academic papers
% Based on article class with custom formatting
% For use with pdflatex, xelatex & lualatex

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cidlab/cidlab}[2024/12/19, v2.0 Modern academic document class]

% Option for line numbers
\newif\if@cidlablineno
\DeclareOption{lineno}{\@cidlablinenotrue}

% Option for draft mode (APA format)
\newif\if@cidlabapadraft
\DeclareOption{apadraft}{\@cidlabapadrafttrue}

% Pass other options to article class (but not draft)
\DeclareOption{9pt}{\PassOptionsToClass{9pt}{extarticle}}
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{extarticle}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{extarticle}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{extarticle}}
\DeclareOption{twocolumn}{\PassOptionsToClass{twocolumn}{extarticle}}
\DeclareOption{onecolumn}{\PassOptionsToClass{onecolumn}{extarticle}}
\DeclareOption{twoside}{\PassOptionsToClass{twoside}{extarticle}}
\DeclareOption{oneside}{\PassOptionsToClass{oneside}{extarticle}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions*

% Load base class
\if@cidlabapadraft
  \LoadClass[12pt,onecolumn,oneside]{article}
\else
  \LoadClass[9pt,twocolumn,twoside]{extarticle}
\fi

% Debug: Check if draft mode is active
\typeout{Draft mode: \if@cidlabapadraft active\else inactive\fi}

% Load required packages
\RequirePackage{microtype}

%% Fonts and language
% \RequirePackage[utf8]{inputenc}
\RequirePackage[english]{babel}
\RequirePackage{amsmath,amsfonts,amssymb}
\RequirePackage{lmodern}
\RequirePackage[scaled]{helvet}
\RequirePackage[T1]{fontenc}
\RequirePackage{lettrine} % For dropped capitals

%% For the Significance Statement & footnote on the first page
\RequirePackage{afterpage}
\RequirePackage{ifpdf,ifxetex}
\ifpdf\else
  \ifxetex\else
    \def\pgfsysdriver{pgfsys-dvipdfm.def}
    \pdfpagewidth=\paperwidth
    \pdfpageheight=\paperheight
\fi\fi
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{tikz}
\RequirePackage[framemethod=tikz]{mdframed}

%% For single column equations and balancing the columns on final page
\RequirePackage{cidlab/widetext}

%% Hyperlinking
\definecolor{oxfordblue}{rgb}{0.0, 0.13, 0.28}
\RequirePackage[colorlinks=true, allcolors=oxfordblue]{hyperref}

%% Set up main title page fonts 
\newcommand{\headerfont}{\normalfont\sffamily\fontsize{7}{9} \selectfont}
\newcommand{\footerfont}{\normalfont\sffamily\fontsize{7}{9} \selectfont}
\newcommand{\titlefont}{\fontfamily{lmss}\bfseries\fontsize{20pt}{23pt}\selectfont}
\newcommand{\dropcapfont}{\fontfamily{lmss}\bfseries\fontsize{26pt}{28pt}\selectfont}
\newcommand{\datesfont}{\normalfont\sffamily\fontsize{7}{8}\selectfont}
\newcommand{\absfont}{\normalfont\sffamily\bfseries\fontsize{8}{11}\selectfont}
\newcommand{\keywordsfont}{\normalfont\rmfamily\fontsize{7}{10}\selectfont}
\newcommand{\copyrightfont}{\normalfont\rmfamily\fontsize{6}{8}\selectfont}

%% Set URL link color & font
\renewcommand\UrlFont{\color{black}\sffamily}

%% Author and affiliation
\RequirePackage{authblk}
\setlength{\affilsep}{8.5pt} % 16.5pts between base of author line and base of affil line
\renewcommand\Authfont{\color{color0}\normalfont\sffamily\bfseries\fontsize{9}{11}\selectfont}
\renewcommand\Affilfont{\color{color0}\normalfont\sffamily\fontsize{7}{8}\selectfont}
\makeatletter
\renewcommand\AB@affilsepx{; \protect\Affilfont}
\makeatother
\renewcommand\Authands{, and }

%% Choose template type
\newcommand*{\templatetype}[1]{%
  \RequirePackage{#1}}

%% Options for element switching
\RequirePackage{xifthen}
\newboolean{shortarticle}
\newboolean{singlecolumn}

%% For numbering just one line of an equation
\newcommand\numberthis{\addtocounter{equation}{1}\tag{\theequation}}

%% Watermark functionality removed
\RequirePackage[printwatermark]{xwatermark}
\newboolean{displaywatermark}
\setboolean{displaywatermark}{true} % Set to false to remove the watermark
\AtBeginDocument{%
  \ifthenelse{\boolean{displaywatermark}}{%
  \newwatermark[allpages,color=gray!20,angle=45,scale=2.75,xpos=0,ypos=0]{\textsc{joke paper\\do not distribute\\do not cite}}}{}
}

%% Copyright statement (not used)
\newboolean{displaycopyright}
\setboolean{displaycopyright}{false} % Confirmed as not required
\RequirePackage{textcomp} % For copyright symbol styling
\newcommand{\copyrightstatement}{\, \textcopyright\, 2017 by the authors}

%% Graphics, tables and other formatting
\RequirePackage{graphicx,xcolor}
\RequirePackage{colortbl}
\RequirePackage{booktabs}
\RequirePackage{algorithm}
\RequirePackage[noend]{algpseudocode}
\RequirePackage{changepage}
\RequirePackage[twoside,%
				letterpaper,includeheadfoot,%
				layoutsize={8.125in,10.875in},%
                layouthoffset=0.1875in,%
                layoutvoffset=0.0625in,%
                left=38.5pt,%
                right=43pt,%
                top=43pt,% 10pt provided by headsep
                bottom=32pt,%
                headheight=0pt,% No Header
                headsep=10pt,%
                footskip=25pt]{geometry}
\RequirePackage[labelfont={bf,sf},%
                labelsep=period,%
                figurename=Fig.]{caption}
\setlength{\columnsep}{13.5pt} % Distance between the two columns of text
\setlength{\parindent}{12pt} % Paragraph indent

%% Set document color scheme
\definecolor{black50}{gray}{0.5} % 50% black for hrules
\definecolor{color0}{RGB}{0,0,0} % Base
\definecolor{color1}{RGB}{59,90,198} % author email, doi
\definecolor{color2}{RGB}{16,131,16} %
% For sig statement box
\definecolor{cidlabbluetext}{RGB}{0,101,165} %
\definecolor{cidlabblueback}{RGB}{205,217,235} %

%% Bibliography
\RequirePackage{apacite}
\bibliographystyle{apacite}

\makeatletter 
\renewcommand\@biblabel[1]{} % Remove brackets from label
\def\tagform@#1{\maketag@@@{\it(\ignorespaces#1\unskip\@@italiccorr)}}
\renewcommand{\eqref}[1]{\textup{{\normalfont Eq.~(\ref{#1}}\normalfont)}}
\makeatother

%% Figure caption style
\DeclareCaptionFormat{cidlabformat}{\normalfont\sffamily\fontsize{7}{9}\selectfont#1#2#3}
\captionsetup*{format=cidlabformat}

%% Table style
\RequirePackage{etoolbox}
\captionsetup*[table]{labelfont+={small},textfont+={small,sf,bf},skip=10pt,position=above}
% booktabs provide nice spacing, but rule widths and distances need fixing
\setlength{\heavyrulewidth}{0.5pt}
\setlength{\lightrulewidth}{0.5pt}
\setlength{\aboverulesep}{1.5pt}
\setlength{\belowrulesep}{1.5pt}
\setlength{\belowbottomsep}{10pt}
\AtBeginEnvironment{tabular}{
\sffamily\fontsize{7.5}{10}\selectfont
}
\newcommand{\addtabletext}[1]{{\setlength{\leftskip}{9pt}\fontsize{7}{9}\selectfont#1}}

%% Equation numbering - use square brackets
\makeatletter
\renewcommand\tagform@[1]{\maketag@@@ {[\ignorespaces #1\unskip \@@italiccorr ]}}
\makeatother

%% Headers and footers
\RequirePackage{fancyhdr}  % custom headers/footers
\RequirePackage{lastpage}  % Number of pages in the document
\pagestyle{fancy}          % Enables the custom headers/footers

%% For the line numbers overlay
\def\leftlinenos{%
  \pgfmathtruncatemacro{\leftstartlineno}{2*(\thepage - 1)*62 + 1}%
  \pgfmathtruncatemacro{\leftendlineno}{(2*(\thepage - 1) + 1)*62}%
  \foreach \x in {\leftstartlineno,...,\leftendlineno}{\noindent\x\\}%
}
\def\rightlinenos{%
  \pgfmathtruncatemacro{\rightstartlineno}{(2*(\thepage - 1) + 1)*62 + 1}%
  \pgfmathtruncatemacro{\rightendlineno}{(2*\thepage)*62}%
  \foreach \x in {\rightstartlineno,...,\rightendlineno}{\noindent\x\\}%
}

\makeatletter
\fancypagestyle{firststyle}{
   \fancyfoot[R]{\footerfont Cognition and Individual Differences lab\hspace{7pt}|\hspace{7pt}\textbf{\today}\hspace{7pt}|\hspace{7pt}cidlab.com\hspace{7pt}|\hspace{7pt}\textbf{\thepage\textendash\pageref{LastPage}}}
   \fancyfoot[L]{\footerfont\@ifundefined{@doi}{}{\@doi}}
}
\makeatother

% Headers
\fancyhead[LE,RO]{}
\fancyhead[LO,RE]{}
% Footers
\lfoot{}%
\cfoot{}%
\rfoot{}%
\makeatletter
\fancyfoot[LE]{\footerfont\textbf{\thepage}\hspace{7pt}|\hspace{7pt}\@ifundefined{@doi}{}{\@doi}}
\fancyfoot[RO]{\footerfont 
Cognition and Individual Differences lab
\hspace{7pt}|\hspace{7pt}
University of California, Irvine
\hspace{7pt}|\hspace{7pt}
cidlab.com
\hspace{7pt}|\hspace{7pt}
\textbf{\today}
\hspace{7pt}|\hspace{7pt}
\textbf{\thepage}
}
\fancyfoot[RE,LO]{\footerfont\@ifundefined{@leadauthor}{}{\@leadauthor}\ifnum \value{authors} > 1\hspace{5pt}\textit{et al.}\fi}

% Use footer routine for line numbers
\AtBeginDocument{
  \if@cidlablineno
    \ifthenelse{\boolean{singlecolumn}}{
      % use lineno package if singlecolumn
      \RequirePackage{lineno}
      \linenumbers
    }{% use tikz if twocolumn
    \fancyfoot[C]{\begin{tikzpicture}[remember picture,overlay]
    \node at([xshift=1.5em,yshift=\dimexpr -0.0625in-53pt] current page.north west)[anchor=north west,text width=3em,font=\rmfamily,align=right] {\leftlinenos};%
    \node at([xshift=-1.5em,yshift=\dimexpr -0.0625in-53pt] current page.north east)[anchor=north east,text width=3em,font=\rmfamily,align=left] {\rightlinenos};%
    \end{tikzpicture}}
    }
  \fi
}
\makeatother

\renewcommand{\headrulewidth}{0pt}% % No header rule
\renewcommand{\footrulewidth}{0pt}% % No footer rule

%% Section/subsection/paragraph set-up - All numbering removed
% Load titlesec package for clean section formatting
\RequirePackage[explicit]{titlesec}

% Remove all section numbering
\renewcommand{\thesection}{}
\renewcommand{\thesubsection}{}
\renewcommand{\thesubsubsection}{}

% Use titlesec for clean, unnumbered section formatting
\titleformat{\section}
  {\normalfont\large\sffamily\bfseries\color{color2}}
  {}
  {0pt}
  {#1}

\titleformat{\subsection}[runin]
  {\normalfont\sffamily\bfseries}
  {}
  {0pt}
  {#1.}

\titleformat{\subsubsection}
  {\normalfont\sffamily\small\bfseries\itshape}
  {}
  {0pt}
  {#1}

% Remove spacing around sections
\titlespacing*{\section}{0pt}{1.5ex}{1ex}
\titlespacing{\subsection}{0pt}{0.5ex}{1em}
\titlespacing{\subsubsection}{0pt}{0ex}{0ex}

%% Article meta data additional fields
\makeatletter
\newcommand{\additionalelement}[1]{\def\@additionalelement{#1}}
\newcommand{\dates}[1]{\def\@dates{#1}}
% \newcommand{\doi}[1]{\def\@doi{#1}}
\newcommand{\leadauthor}[1]{\def\@leadauthor{#1}}
\newcommand{\etal}[1]{\def\@etal{#1}}
\newcommand{\keywords}[1]{\def\@keywords{#1}}
\newcommand{\authorcontributions}[1]{\def\@authorcontributions{#1}}
\newcommand{\authordeclaration}[1]{\def\@authordeclaration{#1}}
\newcommand{\equalauthors}[1]{\def\@equalauthors{#1}}
\newcommand{\correspondingauthor}[1]{\def\@correspondingauthor{#1}}
\newcommand{\significancestatement}[1]{\def\@significancestatement{#1}}
\newcommand{\matmethods}[1]{\def\@matmethods{#1}}
\newcommand{\acknow}[1]{\def\@acknow{#1}}
\makeatother

%% Dropped capital for first letter of main text
\newcommand{\dropcap}[1]{\lettrine[lines=2,lraise=0.05,findent=0.1em, nindent=0em]{{\dropcapfont{#1}}}{}}

%% Abstract formatting
\def\xabstract{abstract}
\long\def\abstract#1\end#2{\def\two{#2}\ifx\two\xabstract 
\long\gdef\theabstract{\ignorespaces#1}
\def\go{\end{abstract}}\else
\typeout{^^J^^J PLEASE DO NOT USE ANY \string\begin\space \string\end^^J
COMMANDS WITHIN ABSTRACT^^J^^J}#1\end{#2}
\gdef\theabstract{\vskip12pt BADLY FORMED ABSTRACT: PLEASE DO
NOT USE {\tt\string\begin...\string\end} COMMANDS WITHIN
THE ABSTRACT\vskip12pt}\let\go\relax\fi
\go}

% Define an environment with abstract content and styling
\makeatletter
\newcommand{\abscontent}{
\noindent
{%
\parbox{\dimexpr\linewidth}{%
    \vskip3pt%
	\absfont \theabstract
}%
}%
\vskip10pt%
\noindent
{\parbox{\dimexpr\linewidth}{%
{
 \keywordsfont \@ifundefined{@keywords}{}{\@keywords}}%
}}%
\vskip12pt%
}
\makeatother

% Option to format abstract differently for certain layouts (not used)
\newcommand{\abscontentformatted}{
\abscontent
}

%% Manual adjustment to line up main content with line numbers
\makeatletter
\newlength\cidlab@vertadjust
\newcommand\verticaladjustment[1]{\setlength{\cidlab@vertadjust}{#1}}
\makeatother

%% Custom title page 
\makeatletter
\renewcommand{\@maketitle}{%
{%
\ifthenelse{\boolean{shortarticle}}
{\ifthenelse{\boolean{singlecolumn}}{}{
{\raggedright\baselineskip= 24pt\titlefont \@title\par}%
\vskip10pt% 21pts between base of title and base of author line
{\raggedright \@author\par}
\vskip8pt% 16pts between base of affiliations and base of dates line 
{\raggedright \datesfont \@ifundefined{@dates}{}{\@dates}\par}
\vskip12pt%
}}
{% else
%
\vskip10pt%
{\raggedright\baselineskip= 24pt\titlefont \@title\par}%
\vskip10pt% 21pts between base of title and base of author line
{\raggedright \@author\par}
\vskip8pt% 16pts between base of affiliations and base of dates line 
{\raggedright \datesfont \@ifundefined{@dates}{}{\@dates}\par}
\vskip12pt
{%
\abscontent
}%
\vskip25pt%
}%
%%%
\@ifundefined{@additionalelement}{}{\@additionalelement}
}%
\vskip\cidlab@vertadjust
}%
\makeatother

%% Footnotes set up
\RequirePackage[flushmargin,ragged]{footmisc}
\renewcommand*{\footnotelayout}{\normalfont\sffamily\fontsize{6}{8}\selectfont} % set the footnote font
\renewcommand{\footnoterule}{% Set the footnote hrule style
  \kern -3pt
  {\color{black50} \hrule width 72pt height 0.25pt}
  \kern 2.5pt
}

%% Other packages
\RequirePackage{enumitem} % For reducing bullet list item separation

%% For sidecaptions
\RequirePackage[rightcaption]{sidecap}

%% Automatically load the appropriate style package
% \typeout{Loading style package...}
% \typeout{Draft flag value: \if@cidlabapadraft true\else false\fi}
% \if@cidlabapadraft
%   \typeout{Loading cidlab-draft.sty}
%   \RequirePackage{cidlab-draft}
% \else
\typeout{Loading cidlab.sty}
\RequirePackage{cidlab/cidlab}
% \fi

\endinput
