\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{berichtclass}
\LoadClass[a4paper,11pt,DIV=12,titlepage,oneside,parskip=half,ngerman]{scrartcl}
                                                % https://de.mirrors.cicku.me/ctan/macros/latex/contrib/koma-script/doc/scrguide-de.pdf

\RedeclareSectionCommands[beforeskip=-1sp,afterskip=1sp]{section, subsection, subsubsection}      % change distancing for all three instances (Never use more than three instance numbering x.y.z)
 \RedeclareSectionCommand[    % change aswell for 4th instance. I just use \paragraph for typesetting bold, ariallike font as an "inline"paragraph header. 
  beforeskip=-1sp,            % Fast null, verhindert aber Einzug
  afterskip=-0.5em            % Fast null, aber der parskip von 0.5\baselineskip wirkt ja noch
]{paragraph}

\counterwithin{figure}{section}                 % enable in section (first instance) numbering, even when no double sided class (book) is used 
\counterwithin{table}{section}     
\counterwithin{equation}{section}

%% ------------------     
%%      Packages      any documentation can be found by typing 'texdoc <package-name>' into the terminal. Or by searching for the package documenation online, all are hosted on https://www.ctan.org/ (Comprehensive-TeX-Archive-Network)
%% ------------------  for native LaTeX-kernel commands type 'texdoc latex2e' or 'texdoc interface3' - you'll find the command there 


\usepackage[l2tabu, orthodox]{nag}              % learn best practices (no old typewriting)
\usepackage[utf8]{inputenc}                     % for using utf8 chars (äöüß)
\usepackage[T1]{fontenc}                        % for correct font encoding (you 
                                                % can't search for non-ascii 
                                                % chars in pdf otherwise)
\usepackage{lmodern}                            % the font used by T1 font enc
                                                
\usepackage[activate={true,nocompatibility},final,tracking=true,kerning=true,spacing=true,factor=1100,stretch=10,shrink=10]{microtype}
% microtype package for better line breaks, kerning, etc
% activate={true,nocompatibility} - activate protrusion and expansion
% final - enable microtype; use "draft" to disable
% tracking=true, kerning=true, spacing=true - activate these techniques
% factor=1100 - add 10% to the protrusion amount (default is 1000)
% stretch=10, shrink=10 - reduce stretchability/shrinkability (default is 20/20)
% https://www.khirevich.com/latex/microtype/

\microtypecontext{spacing=nonfrench}            % option for scrbook to allow 
                                                % microtype->nonfrenchspacing
                                                % for info on nonfrenchspacing:
                                                % en.wikipedia.org/wiki/       \
                                                % History_of_sentence_spacing# \
                                                % French_and_English_spacing

\usepackage[english,ngerman]{babel}             % babel language styles. you may add languages, if need to be
\usepackage{csquotes}                           % for correct enquoting /\enquote), advied/used by biblatex aswell
\usepackage{doc}
\usepackage[backend=biber,backref=true,defernumbers=true,url=true,alldates=terse]{biblatex} % aktuelles Bibliography Package. Options: backref: enable hyperref from bibliography back to the local citation. defernumbers=true: adviced for multiple bibliographys. url: always show url, regardless of the style. alldates=terse: at least in english, dates are written like 11/03/2026, german language fucks it up  
\addbibresource{lit.bib}                         % initialisieren der .bib Datei
                                                % https://mirror.clientvps.com/CTAN/macros/latex/contrib/biblatex/doc/biblatex.pdf; backref=true enables backreferencing from bib to document, is supressed by draft class
                                                % https://tug.ctan.org/info/biblatex-cheatsheet/biblatex-cheatsheet.pdf
\usepackage{amsmath}                            % lots of math packages
\usepackage{amssymb}                            % ... even more math packages
\usepackage{mathtools}
     
\usepackage{upgreek}                            % use $\uppi$ etc.
\usepackage{nicefrac}                           % use \nicefrac{1}{2} 
                                                % for inline text, if you want

\usepackage[locale=DE]{siunitx} % package for units. https://texdoc.org/serve/siunitx/0. Setup: By documentclass ngerman, list and range seperator are changed to german, nonetheless (probably faster for siunitx to compile) we change locale=DE, but this also changes decimal marker to comma, so we need to manually overwrite it.
\sisetup{range-units=single,per-mode=fraction,separate-uncertainty=true,output-decimal-marker={.}}
\DeclareSIUnit\cm{cm}  
\DeclareSIUnit{\Nm}{Nm}
\DeclareSIUnit{\rpm}{rpm}

\usepackage[version=3]{mhchem}                  % to nicely write chemcial 
                                                % elements (e.g.
                                                % \ce{^{227}_{90}Th+})
\usepackage{listings}                       % for displaying code
\lstdefinestyle{SQL}{
    frameround=fttt,
    language=SQL,
    numbers=left,
    breaklines=true,
    keywordstyle=\color{blue}\bfseries, 
    basicstyle=\ttfamily\color{red},
    numberstyle=\color{black}
}
    
\usepackage[automark,headsepline=true]{scrlayer-scrpage}         % for headers, layout. Options: automark: enables rememberig current sectionname (just use \section{<name>}, if they should differ use \section[<toc/automark name>]{<displayed as local heading>}), this information is stored inside automark

\usepackage{placeins}                           % forcing a float to appear above \FloatBarrier
\usepackage{setspace}                           % \onehalfspacing ensures relaxing readibility
\onehalfspacing

% \usepackage[noautomatic]{imakeidx}              % use \makeindex to start indexing; \index{<name>} <name> to index a word appearing on page x; \printindex prints the Index(Register) with <name> x

\usepackage{graphicx}                           % including images
\graphicspath{{./images/}}
\usepackage{newfloat}                           % create custom floats like Memes, Diagrams,..
\usepackage{tikz}                               % \tikz[remember picture, baseline=(node-name.base)]\node[inner sep=0pt](node-name){Wort}; für inline Mode Pfeile               
% \usepackage{inlinegraphicx}

\DeclareGraphicsRule{*}{mps}{*}{}               % enables compiling 
                                                % images with pdf-latex
\DeclareGraphicsExtensions{.eps,                % different image exts used
                           .pdf,
                           .png,
                           .jpg,
                           .jpeg,
                           .mps}
\usepackage{pdfpages}                           % include pdfs with \includepdf; https://www.namsu.de/Extra/pakete/Pdfpages.html                                          
\usepackage{epstopdf}                           % may be necessary for miktex to 
                                                % convert eps to pdf figures

\usepackage[format=hang,font={small,color=black},labelfont=bf,margin=2em]{caption}            
% create graphics captions; documentation: https://mirror.clientvps.com/CTAN/macros/latex/contrib/caption/caption.pdf
\usepackage{subcaption}                         %for \subfigure \subtable
\captionsetup[subfigure]{labelfont=md}
\captionsetup[subtable]{labelfont=md}

% \usepackage{svg}                                

% \usepackage{etoolbox}                           % necessary to update page 
                                                % numbering for chapters
% \usepackage{xstring}                          % used for creating substring 
                                                % out of \appendixname

\usepackage{wrapfig}
\usepackage{lipsum}
\usepackage{enumitem}

% TABULARS:
\usepackage[table]{xcolor}                      % used for some coloring commands. table option for  beautiful colored tables. https://www.overleaf.com/learn/latex/Using_colors_in_LaTeX
\definecolor{blueurllink}{RGB}{51,102,204}
\definecolor{resultscolor}{RGB}{10,21,68}
\definecolor{resultsbackground}{RGB}{219,229,241}

\usepackage[theorems,skins]{tcolorbox}                % use [many] for more options. https://www.tug.org/docs/latex/tcolorbox/tcolorbox.pdf color finder: https://paletton.com/#uid=1000u0kllllaFw0g0qFqFg0w0aF

\usepackage{booktabs}                           %\toprule, \midrule, \bottomrule
                                                % \cmidrule[x pt](l r{.75em}){1-3}  %<- macht nur unter Spalten 1-3 ne Linie mit Dicke x pt, wobei die Linie links default 0.5em getrimmt wird und rechts 0.75em)
                                                % \setlength{\cmidrulekern}{0.25em} % Globales anpassen des Trimmens, geht auch (cmidrulekern ist das Argument von l und r)
                                                % anstatt den default commands \hline, \cline(1-3)):
                                                % \setlength{\abovetopsep}{0.5em}   % provide space between caption and top rule
                                                % \setlength{\tabcolsep}{3.7pt}     % Anpassen der default Spaltenabstände

\usepackage[math,column=Q]{cellspace}
\usepackage{array}                              % Bsp:\newcolumntype{name}{definition} like simplest: \newcolumntype{C}{>{$}c<{$}} % macht Mathemodus-Spalten \href{https://tex.stackexchange.com/questions/257128/how-does-the-newcolumntype-command-work}
\usepackage{tabularx}                           % \href{https://tex.stackexchange.com/questions/341205/what-is-the-difference-between-tabular-tabular-and-tabularx-environments}
\usepackage{makecell}                           % \href{https://tex.stackexchange.com/questions/67047/not-enough-space-in-table-for-fractions}
\usepackage{arraycols}                          % https://ctan.math.utah.edu/ctan/tex-archive/macros/latex/contrib/arraycols/arraycols.pdf
\usepackage{multirow}
\usepackage{multicol}

\usepackage[raiselinks=true,                    % package enables hyperlinks indocument. hyperref also incl.url package for \url{...}.
            bookmarks=true,                     % hyperindex=true, option not given, because index package not needed yet
            bookmarksopenlevel=1,               
            bookmarksnumbered=true, 
            pageanchor=true,
            plainpages=false,
            pdfpagelabels=true,
            pdfnewwindow=true,
            colorlinks=true,allcolors=.]{hyperref}
\hypersetup{urlcolor=blueurllink}               % set all linkcolors to . \eqv fontcolor, except urlcolor. 
                                                % by manually using urlcolor=. inside the bibheading coe, the bibliography is uncolored.
\usepackage[ngerman]{cleveref}                  % load option ngerman (the global option didn't get passed down idk why; and abbreviations; use \cref{} to reference; https://www.namsu.de/Extra/pakete/Cleveref.html
\usepackage{showkeys}                           % to show labels inside the compiled document

\setlength {\marginparwidth }{2cm}
\usepackage{todonotes}                        % supercool to insert todo reminders, that are displayed in the margins


%% --------------------------
%% |    Globale Settings    |
%% --------------------------
\setcounter{secnumdepth}{3}           % Numbering also for \subsubsections
\setcounter{tocdepth}{3}              % Register \subsubsections in content dir

\newcommand{\blankpage}{\clearpage{\pagestyle{empty}\clearpage}}


\endinput
