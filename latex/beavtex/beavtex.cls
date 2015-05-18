\def\filename{beavtex}
\def\fileversion{v0.3}
\def\filedate{2005/05/20}

%--------------------------------------------------------------------
% BeavTeX
% Oregon State University Thesis Class
% Culled from various sources
% John Metta
% <john@jmetta.com>
%--------------------------------------------------------------------
% Provides beavtex.cls file, example files and documention.
% Provides support for LyX OSU thesis textclass layouts and templates
%--------------------------------------------------------------------
% ToDo: Conditional linebreaks for title, major, second major.
%       The titles and majors do not automatically linebreak when 
%       they are too long to completely fit on the end of a line.

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{\filename}[\filedate\space\fileversion\space%
  BeavTeX: OSU thesis class]

\RequirePackage{setspace}
\RequirePackage{ifthen}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initialize and Set up class

% ----- Define BeavTeX ---------------------------
\def\beavtex{$\rm{B^{\kern-.1em\textsc{e}}\ \kern-.6em_{\textsc{a}}\kern-.4em\textsc{v}}$\kern-.3em\TeX\ }
\def\beavtexnospace{$\rm{B^{\kern-.1em\textsc{e}}\ \kern-.6em_{\textsc{a}}\kern-.4em\textsc{v}}$\kern-.3em\TeX}

% ------ Left margin width to 1.5 (minimum) or 1.7 (recommended)
\def\@marwidth{.7in}
\def\@texwidth{5.7in}
\DeclareOption{1.5}{
  \def\@marwidth{.5in}
  \def\@texwidth{5.9in}
}
%\makeatletter
%\DeclareRobustCommand\firstchapset{%
%  \global\let\firstchapset\relax
%  \pagestyle{thesis}
%  \thispagestyle{empty}
%  \pagenumbering{arabic}
%  \setcounter{page}{1}
%}
%\g@addto@macro\cl@chapter{\firstchapset}
%\makeatother

% ----  Thesis is a modified (default 12pt) book style  ---------
\def\bookclass{book}
\def\@f@ntsize{12pt}
\DeclareOption{10pt}{\def\@f@ntsize{10pt}}
\DeclareOption{11pt}{\def\@f@ntsize{11pt}}
\DeclareOption{12pt}{\def\@f@ntsize{12pt}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\bookclass}}
\ProcessOptions
\PassOptionsToClass{\@f@ntsize}{\bookclass}
\PassOptionsToClass{openany}{\bookclass}
\ProcessOptions
\LoadClass{book}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Options 

% ----- Margin widths ------------------
\oddsidemargin \@marwidth
\evensidemargin \@marwidth
\textwidth \@texwidth
\topmargin 0.1in %distance from header to margin
\headheight 14pt
\headsep .4in
\footskip 30pt

% ------ Some random options --------------------
\def\ruleline{\hbox{\leaders\hrule\hskip360pt}}
% Allow big skip between floats
\newcommand{\bigfloatskip}{false}

\def\ps@thesis{
  \def\@evenhead{\vbox to \headheight{\hfil\break
      \rm\flushright\thepage\break}}
  \def\@oddhead{\vbox to \headheight{\hfil\break
      \rm\flushright\thepage\break}}
  \def\@oddfoot{}
  \def\@evenfoot{}
}

\let\origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{%
  \clearpage
  {\pagestyle{empty}\origdoublepage}%
}
\let\cleardoublepage\clearemptydoublepage

\let\ps@plain\ps@thesis

\newcommand\firstchap{
  \pagestyle{thesis}
  \thispagestyle{empty}
  \setcounter{page}{1}
}

\def\pagealignment#1{\gdef\@pagealignment{#1}} \pagealignment{}

% ----- Chapter redefinition ----------------
% This redefinition of chapter makes page
% number one be the first page after the contents
% lists (first page of body) and print with no numbering
% it also changes the heading style for the rest of the
% thesis to ``thesis'' style
\renewcommand{\chapter}{
  \if@openright\cleardoublepage\else\clearpage\fi
  \ifnum\value{chapter}=0
    \thispagestyle{empty}
    \pagestyle{thesis}
    \setcounter{page}{1}
    \@pagealignment
  \else\fi
%    \thispagestyle{plain}%
    \@pagealignment
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter
}

% ------ Footnotes/captions ---------------------
% for captions and footnote to be single spaced
\def\Footnote#1{\def\baselinestretch{1}\footnote{#1}}
\def\Caption#1{\def\baselinestretch{1}\vskip 28pt\caption{#1}}
\def\CCaption[#1]#2{\def\baselinestretch{1}\vskip 28pt\caption[#1]{#2}}

%------ Holdovers from original osuthesis.sty

% the following are for use with lists with small interline spacing
\newenvironment{smallitem}{
  \setlength{\topsep}{0pt}
  \setlength{\partopsep}{0pt}
  \setlength{\parskip}{0pt}
  \begin{itemize}
    \setlength{\leftmargin}{.2in}
    \setlength{\parsep}{0pt}
    \setlength{\parskip}{0pt}
    \setlength{\itemsep}{0pt}}{\end{itemize}}
\newenvironment{smallenum}{
  \setlength{\topsep}{0pt}
  \setlength{\partopsep}{0pt}

  \setlength{\parskip}{0pt}
  \begin{enumerate}
    \setlength{\leftmargin}{.2in}
    \setlength{\parsep}{0pt}
    \setlength{\parskip}{0pt}
    \setlength{\itemsep}{0pt}}{\end{enumerate}}

% Big or small spaces for floats
\if\bigfloatskip true{
  \setlength{\floatsep}{42pt}
  \setlength{\textfloatsep}{42pt}
  \setlength{\intextsep}{42pt}
}{
  \setlength{\floatsep}{20pt}
  \setlength{\textfloatsep}{20pt}
  \setlength{\intextsep}{20pt}
}\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%% User definitions

\def\title#1{\gdef\@title{#1}}
\def\twotitle#1{\gdef\@twotitle{#1}} \twotitle{}
\def\fulltitle{\@title \@twotitle}
\def\author#1{\gdef\@author{#1}}
\def\degree#1{\gdef\@degree{#1}}

%\newcount\numcomm \numcomm=1
%\def\signaturelines#1{\numcomm=#1}

\def\doctype#1{\gdef\@doctype{#1}}
\def\major#1{\gdef\@major{#1}}
\def\twomajor#1{\gdef\@twomajor{#1}} \twomajor{*}
\def\department#1{\gdef\@department{#1}}
\def\twodepartment#1{\gdef\@twodepartment{#1}} \twodepartment{*}

\def\advisor#1{\gdef\@advisor{#1}}
\def\coadvisor#1{\gdef\@coadvisor{#1}} \coadvisor{*}
\def\depthead#1{\gdef\@depthead{#1}} \depthead{Chair}
\def\twodepthead#1{\gdef\@twodepthead{#1}} \twodepthead{Chair}
\def\depttype#1{\gdef\@depttype{#1}} \depttype{Department}
\def\twodepttype#1{\gdef\@twodepttype{#1}} \twodepttype{Department}

\def\advisorstring{\if\@coadvisor * \hfil\@advisor\else \hfil\@advisor\hspace{1in}\@coadvisor\fi \hfil\break}

% are these still necessary
\def\memberone#1{\gdef\@memberone{#1}}
\def\membertwo#1{\gdef\@membertwo{#1}}
\def\memberthree#1{\gdef\@memberthree{#1}}
\def\memberfour#1{\gdef\@memberfour{#1}}
\def\memberfive#1{\gdef\@memberfive{#1}}
\def\membersix#1{\gdef\@membersix{#1}}


\def\copyrightyear#1{\gdef\@copyrightyear{#1}} \copyrightyear{\the\year}
\def\submitdate#1{\gdef\@submitdate{#1}} \submitdate{\today}
\def\commencementyear#1{\gdef\@commencementyear{#1}} \commencementyear{\the\year}

%\newcommand{\abstract}[1]{#1}
\def\abstract#1{\gdef\@abstract{#1}} \abstract{*}
\def\acknowledgements#1{\gdef\@acknowledgements{#1}} \acknowledgements{*}
\def\contributors#1{\gdef\@contributors{#1}} \contributors{*}
\def\preface#1{\gdef\@preface{#1}} \preface{*}
\def\dedication#1{\gdef\@dedication{#1}} \dedication{*}

\def\chapheadsep#1{\gdef\@chapheadsep{#1}} \chapheadsep{\ --}
\def\chapword#1{\gdef\@chapword{#1\ }} \chapword{}
\def\nopretext#1{\gdef\@nopretext{#1}} \nopretext{false}
\def\depthoftoc#1{\gdef\@depthoftoc{#1}} \depthoftoc{2}
\def\notoddtoc#1{\gdef\@notoddtoc{#1}} \notoddtoc{false}

\def\dedpagestart#1{\gdef\@dedpagestart{#1}} \dedpagestart{\begin{flushleft}}
\def\dedpageend#1{\gdef\@dedpageend{#1}} \dedpageend{\end{flushleft}}
\def\prefpagestart#1{\gdef\@prefpagestart{#1}} \prefpagestart{\begin{flushleft}}
\def\prefpageend#1{\gdef\@prefpageend{#1}} \prefpageend{\end{flushleft}}
\def\ackpagestart#1{\gdef\@ackpagestart{#1}} \ackpagestart{\begin{flushleft}}
\def\ackpageend#1{\gdef\@ackpageend{#1}} \ackpageend{\end{flushleft}}
\def\contpagestart#1{\gdef\@contpagestart{#1}} \contpagestart{\begin{flushleft}}
\def\contpageend#1{\gdef\@contpageend{#1}} \contpageend{\end{flushleft}}
\def\abspagestart#1{\gdef\@abspagestart{#1}} \abspagestart{\begin{flushleft}}
\def\abspageend#1{\gdef\@abspageend{#1}} \abspageend{\end{flushleft}}

\newcommand\ackpagecenter{%
    \ackpagestart{\begin{center}}
    \ackpageend{\end{center}}
}
\newcommand\dedpagecenter{%
    \dedpagestart{\begin{center}}
    \dedpageend{\end{center}}
}
\newcommand\prefpagecenter{%
    \prefpagestart{\begin{center}}
    \prefpageend{\end{center}}
}
\newcommand\contpagecenter{%
    \contpagestart{\begin{center}}
    \contpageend{\end{center}}
}
\newcommand\abspagecenter{%
    \abspagestart{\begin{center}}
    \abspageend{\end{center}}
}

\newcommand\ackpageclear{%
    \ackpagestart{}
    \ackpageend{}
}
\newcommand\dedpageclear{%
    \dedpagestart{}
    \dedpageend{}
}
\newcommand\prefpageclear{%
    \prefpagestart{}
    \prefpageend{}
}
\newcommand\contpageclear{%
    \contpagestart{}
    \contpageend{}
}
\newcommand\abspageclear{%
    \abspagestart{}
    \abspageend{}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Abstract
\def\abpage{
  \pagestyle{empty}
  \mbox{}\pagebreak % force blank page before abstract page
  \vspace{-3.5mm}
  \begin{singlespacing} 
  \begin{center} \Large AN ABSTRACT OF THE THESIS OF \end{center}
  \noindent{\raggedright
      \underline{\@author} for the degree of \underline{\@degree}
      in \if\@twomajor * \underline{\@major} 
      \else
%      \protect\underline{\protect\@major}\ and \underline{\@twomajor}
	\underline{Biological and Ecological}\\\underline{Engineering}\ and \underline{Geography}
      \fi
      presented on \underline{\@submitdate}.\\
      \vskip .1in
%      Title: \if\@twotitle * \underline{\@title}
      Title: \underline{Sensitivity Analysis of the Catchment Modeling Framework (CMF) and Use}\\\underline{in Evaluating Two Agricultural Management Scenarios}
%      \else
%      \underline{\@title}\\\underline{\@twotitle}
      \\
%      \fi
  }
 \hfil\strut\\
  \hbox{Abstract approved:\hskip2pt\leaders\hrule\hskip300pt}\\
  \phantom{Abstract approved:\ }\advisorstring
  \vskip .5in
  \end{singlespacing}
%  \begin{\@linespacing}
    \noindent
    \@abspagestart
    \@abstract
    \@abspageend
%  \end{\@linespacing}
  \newpage
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Copyright
\def\copyrightpage{
  \begin{singlespacing}
  \thispagestyle{empty}
  % Thesis guide demands "10 returns from first line." It's lame,
  % but we'll do it that way
  \strut\\\strut\\\strut\\\strut\\\strut\\
  \\\strut\\\strut\\\strut\\\strut\\
  \begin{center}
    ${}^\copyright$Copyright by \@author\\
    \@submitdate\\
    All Rights Reserved
  \end{center}
  \end{singlespacing}
  \newpage
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Titlepage
\def\titlepage{
  \begin{singlespacing}
  \thispagestyle{empty}
  \vspace{.5in}
  \begin{center}\baselineskip 14.5pt
    \fulltitle\\\strut\\
    by\\
    \@author\\
    \vskip 1.25in
    A \uppercase{\@doctype}\\\strut\\
    submitted to\\\strut\\
    Oregon State University\\
    \vskip 1.25in
    in partial fulfillment of\\
    the requirements for the\\
    degree of\\\strut\\
    \@degree
    \vskip 1.25in
    Presented \@submitdate\\
    Commencement June \@commencementyear
  \end{center}
  \end{singlespacing}
  \newpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter Heading Page for Published Chapters
\newcommand{\headingpage}[5]{
  \newpage
  \begin{singlespacing}
  \thispagestyle{plain}
  \begin{center}
    {\Large \bfseries {#1}}
    \vskip 1.25in
    {#2}
  \end{center}
  \vfill
  {\raggedright{#3}\\{#4}\\{#5}}
  \end{singlespacing}
  \newpage
}  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Acknowledgements
\def\ackpage{
  \thispagestyle{empty}
  \begin{center}\section*{\rm{ACKNOWLEDGEMENTS}}\end{center}
  \noindent
  \vskip .5in
  \@ackpagestart
  \@acknowledgements
  \@ackpageend
  \newpage
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Contributors
\def\contpage{
  \thispagestyle{empty}
  \begin{center}\section*{\rm{CONTRIBUTION OF AUTHORS}}\end{center}
  \noindent
  \vskip .5in
  \@contpagestart
  \@contributors
  \@contpageend
  \newpage
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Dedication
\def\dedpage{
  \thispagestyle{empty}
  \begin{center}\section*{\rm{DEDICATION}}\end{center}
  \noindent
  \vskip .5in
  \@dedpagestart
  \@dedication
  \@dedpageend
  \newpage
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Preface
\def\prefpage{
  \thispagestyle{empty}
  \begin{center}\section*{\rm{PREFACE}}\end{center}
  \noindent
  \vskip .5in
  \@prefpagestart
  \@preface
  \@prefpageend
  \newpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Approval
\def\approvalpage{
  \thispagestyle{empty}
  \begin{singlespacing}
  \noindent
      {\raggedright
	\underline{\@degree} thesis of \underline{\@author} presented on \underline{\@submitdate}.
	\vskip .5in
	APPROVED:\\
	\vskip .5in
	\ruleline
	% Major Professor (Co- if there is a coadvisor}
	\if\@coadvisor *
	\else Co-\fi Major Professor, representing \@major\\
	\vskip .5in
	% Second major professor if exists
	\if\@coadvisor *
	\else\ruleline Co-Major Professor, representing \@twomajor
	\vskip .5in\fi
	\ruleline
	% major department head
	\@depthead\ of the \@depttype\ of \@department\\
	\vskip .5in
	\if\@twodepartment * 
	\else
	% Here is the second Department
	\ruleline \@twodepthead\ of the \@twodepttype\ of \@twodepartment
	\vskip .5in\fi
	\ruleline
	Dean of the Graduate School\\
	\vfill
	I understand that my thesis will become part of the permanent collection of Oregon State University libraries. My signature below authorizes release of my thesis to any reader upon request.
        \vskip .5in
	\ruleline
	\hbox to \textwidth{\hfil \@author, Author \hfil}}
  \end{singlespacing}
      \newpage
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Format all of the frontmatter
\def\pretext{%
   \abpage
   \copyrightpage
   \titlepage
   \approvalpage
      
   % Optional pages
   \if\@acknowledgements * \else\ackpage\fi
   \if\@preface * \else\prefpage\fi
   \if\@contributors * \else\contpage\fi
   \if\@dedication * \else\dedpage\fi
}
\def\maketitle{\if\@nopretext \else\pretext\fi}
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Format the chapter title nicely
\renewcommand{\@makechapterhead}[1]{%
  \vspace*{10\p@}%
	  {
	    
	    \begin{center}
	      \normalfont
	      \ifnum \c@secnumdepth >\m@ne
	      \if@mainmatter
              \Large \@chapword\thechapter\@chapheadsep
	      \fi
	      \fi
	      %\interlinepenalty\@M
	      \Large #1\par\nobreak
	      \vskip 20\p@
	    \end{center}
	  }
}
\renewcommand{\@makeschapterhead}[1]{%
  \vspace*{10\p@}%
	  {
	    \begin{center}
	      \normalfont
	      \Large #1\par\nobreak
	      \vskip 20\p@
	    \end{center}
	  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Make all section/subsection titles
%% The same fontsize: Large
\renewcommand{\section}{\@startsection
  {section}%                   % the name
  {1}%                         % the level
  {0mm}%                       % the indent
  {-\baselineskip}%            % the before skip
  {0.5\baselineskip}%          % the after skip
  {\normalfont\Large}} % the style

\renewcommand{\subsection}{\@startsection
  {subsection}%                   % the name
  {1}%                         % the level
  {0mm}%                       % the indent
  {-\baselineskip}%            % the before skip
  {0.5\baselineskip}%          % the after skip
  {\normalfont\Large}} % the style

\renewcommand{\subsubsection}{\@startsection
  {subsubsection}%                   % the name
  {1}%                         % the level
  {0mm}%                       % the indent
  {-\baselineskip}%            % the before skip
  {0.5\baselineskip}%          % the after skip
  {\normalfont\Large}} % the style

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Table of contents 
%

\def\ps@toca{\def\@oddhead{\vbox to \headheight{
      \centerline{TABLE OF CONTENTS}\hfill \break
      \rm\flushright\protect\underline{Page}\break}}
  \def\@evenhead{\vbox to \headheight{
      \centerline{TABLE OF CONTENTS}\hfill \break
      \rm\flushright\protect\underline{Page}\break}}
  \def\@oddfoot{}
  \def\@evenfoot{}
}
\def\ps@tocb{\def\@evenhead{\vbox to \headheight{
      \centerline{TABLE OF CONTENTS (Continued)}\hfil\break
      \rm\flushright\protect\underline{Page}\break}}
  \def\@oddhead{\vbox to \headheight{
      \centerline{TABLE OF CONTENTS (Continued)}\hfil\break
      \rm\flushright\protect\underline{Page}\break}}
  \def\@oddfoot{}
  \def\@evenfoot{}
}

\def\tableofcontents{
  \vskip 10cm
  \pagestyle{tocb}
  \thispagestyle{toca}
  \setcounter{tocdepth}{\@depthoftoc}
	     {\let\footnotemark\relax  % in case one is in the title
	       \@starttoc{toc}
	     }
}

\def\l@chapter#1#2{\vskip 4pt {\baselineskip 14.5pt
    \@dottedtocline{1}{1pc}{2.8em}{#1}{#2}}\vskip 4pt}

\def\l@section#1#2{\vskip 4pt {\baselineskip 14.5pt%
    \@dottedtocline{1}{3pc}{2.8em}{#1}{#2}} \vskip 4pt }
%
\def\l@subsection#1#2{{\baselineskip 14.5pt%
    \@dottedtocline{2}{6pc}{2.8em}{#1}{#2}}}
%
\def\l@subsubsection#1#2{{\baselineskip 14.5pt%
    \@dottedtocline{3}{9pc}{2.8em}{#1}{#2}}}
%
%
%   List of figures
%
\def\ps@lofa{\def\@oddhead{\vbox to \headheight{
      \centerline{LIST OF FIGURES}\break
      \flushleft\underline{Figure}\hfill\underline{Page}\break}}
  \def\@evenhead{\vbox to \headheight{
      \centerline{LIST OF FIGURES}\break
      \flushleft\underline{Figure}\hfill\underline{Page}\break}}
  \def\@oddfoot{}
  \def\@evenfoot{}
}

\def\ps@lofb{\def\@evenhead{\vbox to \headheight{
      \centerline{LIST OF FIGURES (Continued)}\break
      \flushleft\underline{Figure}\hfill\underline{Page}\break}}
  \def\@oddhead{\vbox to \headheight{
      \centerline{LIST OF FIGURES (Continued)}\break
      \flushleft\underline{Figure}\hfill\underline{Page}\break}}
  \def\@oddfoot{}
  \def\@evenfoot{}
}

\def\l@figure#1#2{\vskip 9.5pt {\baselineskip 14.5pt%
    \@dottedtocline{1}{1.5em}{2.3em}{#1}{#2}}}
\let\l@table\l@figure

\let\l@appendixtable\l@table
\let\l@appendixfigure\l@figure



\def\listoffigures{
  \pagestyle{lofb}
  \thispagestyle{lofa}
		{\let\footnotemark\relax  % in case one is in the title
		  \@starttoc{lof}
		}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  List of tables
\def\ps@lota{\def\@oddhead{\vbox to \headheight{
      \centerline{LIST OF TABLES}\hfil\break\strut
      \rm\protect\underline{Table}\hfill
      \rm\protect\underline{Page}\break }}
  \def\@evenhead{\vbox to \headheight{
      \centerline{LIST OF TABLES}\hfil\break\strut
      \rm\protect\underline{Table}\hfill
      \rm\protect\underline{Page}\break }}
  \def\@oddfoot{}
  \def\@evenfoot{}
}

\def\ps@lotb{\def\@evenhead{\vbox to \headheight{
      \centerline{LIST OF TABLES (Continued)}\hfil\break\strut
      \rm\protect\underline{Table}\hfill
      \rm\hfill\protect\underline{Page}\break }}
  \def\@oddhead{\vbox to \headheight{
      \centerline{LIST OF TABLES (Continued)}\hfil\break\strut
      \rm\protect\underline{Table}\hfill
      \rm\hfill\protect\underline{Page}\break }}
  \def\@oddfoot{}
  \def\@evenfoot{}
}

\def\ps@loata{\def\@oddhead{\vbox to \headheight{
      \centerline{LIST OF APPENDIX TABLES}\hfil\break\strut
      \rm\protect\underline{Table}\hfill
      \rm\protect\underline{Page}\break }}
  \def\@evenhead{\vbox to \headheight{
      \centerline{LIST OF APPENDIX TABLES}\hfil\break\strut
      \rm\protect\underline{Table}\hfill
      \rm\protect\underline{Page}\break }}
  \def\@oddfoot{}
  \def\@evenfoot{}
}

\def\ps@loatb{\def\@evenhead{\vbox to \headheight{
      \centerline{LIST OF APPENDIX TABLES (Continued)}\hfil\break\strut
      \rm\protect\underline{Table}\hfill
      \rm\hfill\protect\underline{Page}\break }}
  \def\@oddhead{\vbox to \headheight{
      \centerline{LIST OF APPENDIX TABLES (Continued)}\hfil\break\strut
      \rm\protect\underline{Table}\hfill
      \rm\hfill\protect\underline{Page}\break }}
  \def\@oddfoot{}
  \def\@evenfoot{}
}

\def\ps@loafa{\def\@oddhead{\vbox to \headheight{
      \centerline{LIST OF APPENDIX FIGURES}\hfil\break\strut
      \rm\protect\underline{Figure}\hfill
      \rm\protect\underline{Page}\break }}
  \def\@evenhead{\vbox to \headheight{
      \centerline{LIST OF APPENDIX FIGURES}\hfil\break\strut
      \rm\protect\underline{Figure}\hfill
      \rm\protect\underline{Page}\break }}
  \def\@oddfoot{}
  \def\@evenfoot{}
}

\def\ps@loafb{\def\@evenhead{\vbox to \headheight{
      \centerline{LIST OF APPENDIX FIGURES(Continued)}\hfil\break\strut
      \rm\protect\underline{Figure}\hfill
      \rm\hfill\protect\underline{Page}\break }}
  \def\@oddhead{\vbox to \headheight{
      \centerline{LIST OF APPENDIX FIGURES(Continued)}\hfil\break\strut
      \rm\protect\underline{Figure}\hfill
      \rm\hfill\protect\underline{Page}\break }}
  \def\@oddfoot{}
  \def\@evenfoot{}
}

\def\listoftables{
  \pagestyle{lotb}
  \thispagestyle{lota}
		{\let\footnotemark\relax  % in case one is in the title
		  \@starttoc{lot}
		}
}

\def\listofappendixtables{
  \pagestyle{loatb}
  \thispagestyle{loata}
		{\let\footnotemark\relax  % in case one is in the title
		  \@starttoc{loat}
		}
}

\def\listofappendixfigures{
  \pagestyle{loafb}
  \thispagestyle{loafa}
		{\let\footnotemark\relax  % in case one is in the title
		  \@starttoc{loaf}
		}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Bibliography
\def\textofBIB#1{\gdef\@textofBIB{#1}}  \textofBIB{Bibliography}
%\def\thebibliography#1{\chapter*{\@textofBIB\@mkboth{}{}}
%  \addcontentsline{toc}{chapter}{\protect\@textofBIB}
%  \list
%      {[\arabic{enumi}]}{\settowidth\labelwidth{[#1]}\leftmargin\labelwidth
%	\advance\leftmargin\labelsep
%	\usecounter{enumi}}
%      \def\newblock{\hskip .11em plus .33em minus .07em}
%      \sloppy\clubpenalty4000\widowpenalty4000
%      \sfcode`\.=1000\relax
%}
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Appendices
\def\textofAPP#1{\gdef\@textofAPP{#1}}  \textofAPP{Appendices}
\def\textofAPP#1{\addcontentsline{toc}{chapter}{\protect\@textofAPP}}

\def\ps@loaa{\def\@oddhead{\vbox to \headheight{
      \centerline{LIST OF APPENDICES}\hfil\break\strut
      \rm\protect\underline{Table}\hfill
      \rm\protect\underline{Page}\break }}
  \def\@evenhead{\vbox to \headheight{
      \centerline{LIST OF APPENDICES}\hfil\break\strut
      \rm\protect\underline{Table}\hfill
      \rm\protect\underline{Page}\break }}
  \def\@oddfoot{}
  \def\@evenfoot{}
}

\def\ps@loab{\def\@oddhead{\vbox to \headheight{
      \centerline{LIST OF APPENDICES (Continued)}\hfil\break\strut
      \rm\protect\underline{Table}\hfill
      \rm\hfill\protect\underline{Page}\break }}
  \def\@evenhead{\vbox to \headheight{
      \centerline{LIST OF APPENDICES (Continued)}\hfil\break\strut
      \rm\protect\underline{Table}\hfill
      \rm\hfill\protect\underline{Page}\break }}
  \def\@oddfoot{}
  \def\@evenfoot{}
}

\def\listofappendices{
  \pagestyle{loab}
  \thispagestyle{loaa}
		{\let\footnotemark\relax  % in case one is in the title
		  \@starttoc{loa}
		}
}


\endinput
