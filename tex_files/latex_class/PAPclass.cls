%%% For this file to be included correctly: follow the instructions in README_global_PAPclass or paste it every time next to main.tex
 
% --- In this file --- 
% check out the options passed to {siunitx}. USE siunitx and don't typeset units yourself
% check out the defined colors (\definecolor) 
% check out the defined tcolorboxes (\newtcolorbox) and set the mathhiglightstyle \tcbset
% define your preferred {hyperref} options

% --- local options are defined in preamble (so check out main.tex)
% your desired strings
% {newfloat} environments
% bibliography file location
% graphics file location
% header and footer text
% caption text (e.g. custom abbreviations)

% --- math commands, figure commands are defined in cmds.tex

\NeedsTeXFormat{LaTeX2e} 
% initialisiert Namen der Klasse, damit dieser von der main.tex gefunden werden kann
\ProvidesClass{PAPclass}[Stand 2.09.2026] % auch wenn PAPclass.cls direkt neben main.tex liegt, bleibt der code hier gleich

% lädt Koma-Script Klasse scrartcl mit Einstellungen. Siehe in knowlede/Latex_main/main.pdf->search "Documentclasses" weitere Möglichkeiten
\LoadClass{scrartcl}
\KOMAoptions{paper=a4,fontsize=11pt,DIV=12,titlepage=true,twoside=false,parskip=half}
% https://de.mirrors.cicku.me/ctan/macros/latex/contrib/koma-script/doc/scrguide-de.pdf
\DeclareTOCStyleEntries[dynnumwidth=true]{tocline}{section,subsection,subsubsection}

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

\RequirePackage[l2tabu, orthodox]{nag}              % learn best practices (no old typewriting)
\RequirePackage[utf8]{inputenc}                     % for using utf8 chars (äöüß)
\RequirePackage[T1]{fontenc}                        % for correct font encoding (you 
                                                % can't search for non-ascii 
                                                % chars in pdf otherwise)
\RequirePackage{lmodern}                            % the font used by T1 font enc
                                                
\RequirePackage[activate={true,nocompatibility},final,tracking=true,kerning=true,spacing=true,factor=1100,stretch=10,shrink=10]{microtype}
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
\RequirePackage{babel}         % babel language styles, the desired language is set by \documentclass[language] in main.tex, so it gets passed down to cleverref and babel simultaneously. You can pass multiple languages: english,ngerman -> Nebensprache, Hauptsprache
\RequirePackage[autostyle=true]{csquotes}       % for correct enquoting \enquote{} and \foreignquote{english}{}, autostyle=true enables automatically looking at the current babel setting), adviced/used by biblatex aswell

\RequirePackage[backend=biber,style=phys,backref=true,defernumbers=true,url=true,alldates=terse]{biblatex} % aktuelles Bibliography Package. Options: backref: enable hyperref from bibliography back to the local citation. defernumbers=true: adviced for multiple bibliographys. url: always show url, regardless of the style. alldates=terse: at least in english, dates are written like 11/03/2026, german language fucks it up  
                                                % https://mirror.clientvps.com/CTAN/macros/latex/contrib/biblatex/doc/biblatex.pdf; backref=true enables backreferencing from bib to document, is supressed by draft class
                                                % https://tug.ctan.org/info/biblatex-cheatsheet/biblatex-cheatsheet.pdf
\RequirePackage{amsmath}                            % lots of math packages
\RequirePackage{amssymb}                            % ... even more math packages
\RequirePackage{mathtools}
\RequirePackage{bm}                                 % check out bm package for yourself, idk what its good for

\RequirePackage{upgreek}                            % use $\uppi$ etc.
\RequirePackage{nicefrac}                           % use \nicefrac{1}{2} 
                                                % for inline text, if you want
\RequirePackage{cancel}                             % for crossing out math stuff with diagcancel \cancel, crosscancel \xcancel 
\RequirePackage{soul}                               % for crossing out text with \st

\RequirePackage[locale=DE]{siunitx} % package for units. https://texdoc.org/serve/siunitx/0. Setup: By documentclass ngerman, list and range seperator are changed to german, nonetheless (probably faster for siunitx to compile) we change locale=DE, but this also changes decimal marker to comma, so we need to manually overwrite it. It also adds space for thousands 1 000, english will do 1,000 bruh
\sisetup{per-mode=fraction,uncertainty-descriptor-mode = subscript,uncertainty-mode=separate,output-decimal-marker={.},exponent-product=\cdot,product-symbol = \ensuremath{\cdot}} % specifies displaying of ranges eg. (1N-3N)
\sisetup{list-units=bracket,range-units=bracket,list-final-separator = {,\:},list-pair-separator  = {,\:},product-units=bracket,list-exponents = combine-bracket,product-exponents = combine-bracket,range-exponents = combine-bracket}
% apply per-mode=reciprocal locally when needed for visual purposes
\DeclareSIUnit\kg{kg}
\DeclareSIUnit\mm{mm}
\DeclareSIUnit\cm{cm}
\DeclareSIUnit\barn{barn}
\DeclareSIUnit{\Nm}{Nm}
\DeclareSIUnit{\rad}{rad}
\DeclareSIUnit\bar{bar}
\DeclareSIUnit{\rpm}{rpm}
\DeclareSIUnit\jahr{a}
\DeclareSIUnit\pixel{pixel}
\DeclareSIUnit\Skt{Skt}
\DeclareSIUnit\hPa{hPa}
\DeclareSIPrefix\twentythree{10^{23}}{23}       % um die einheit der boltzmannkonstante zu texen: \unit{\twentythree\J\per\K}
\DeclareSIPrefix\four{10^{4}}{4}                % Faraday Konstante 
\DeclareSIPrefix\mnineteen{10^{-19}}{-19}                % elementary charge


\RequirePackage[version=4]{mhchem}                  % to nicely write chemcial elements (e.g. \ce{^{227}_{90}Th+})
\RequirePackage{listingsutf8}                       % for displaying code. Use: \lstdefinestyle{SQL}{} to define a new style

\RequirePackage[automark,headsepline=true]{scrlayer-scrpage}         % for headers, layout. Options: automark: enables rememberig current sectionname (just use \section{<name>}, if they should differ use \section[<toc/automark name>]{<displayed as local heading>}), this information is stored inside automark

\RequirePackage{placeins}                           % forcing a float to appear above \FloatBarrier

\RequirePackage{setspace}                           % \onehalfspacing ensures relaxing readibility
\onehalfspacing

% \RequirePackage[noautomatic]{imakeidx}              % use \makeindex to start indexing; \index{<name>} <name> to index a word appearing on page x; \printindex prints the Index(Register) with <name> x
\RequirePackage{tikz}                               % \tikz[remember picture, baseline=(node-name.base)]\node[inner sep=0pt](node-name){Wort}; für inline Mode Pfeile                     
\RequirePackage{graphicx}                           % including images
\RequirePackage{newfloat}                           % create custom floats like Memes, Diagrams,..
% \RequirePackage{inlinegraphicx}
% \RequirePackage{background}                       % obsolete by using \begin{tikzpicture}[overlay], but probably still useful for multiple page backgroudns/watermarks


\DeclareGraphicsRule{*}{mps}{*}{}               % enables compiling 
                                                % images with pdf-latex
\DeclareGraphicsExtensions{.eps,                % different image exts used
                           .pdf,
                           .png,
                           .jpg,
                           .jpeg,
                           .mps}
\RequirePackage{pdfpages}                           % include pdfs with \includepdf; https://www.namsu.de/Extra/pakete/Pdfpages.html  http://www.nagel-net.de/Latex/DOKU/pdfpages.pdf
% \RequirePackage{epstopdf}                           % may be necessary for miktex to 
                                                % convert eps to pdf figures
\RequirePackage[format=hang,font={small,color=black},labelfont=bf,margin=2em]{caption}            
% create graphics captions; documentation: https://mirror.clientvps.com/CTAN/macros/latex/contrib/caption/caption.pdf
\RequirePackage{subcaption}                         % for \subfigure \subtable
\captionsetup[subfigure]{labelfont=md}
\captionsetup[subtable]{labelfont=md}

% \RequirePackage{svg}                                

% \RequirePackage{etoolbox}                           % necessary to update page 
                                                % numbering for chapters
% \RequirePackage{xstring}                          % used for creating substring 
                                                % out of \appendixname
% TABULARS:
\RequirePackage[table]{xcolor}                      % used for some coloring 
                                                % commands. table option for 
                                                % beautiful colored tables. https://www.overleaf.com/learn/latex/Using_colors_in_LaTeX
\definecolor{blueurllink}{RGB}{51,102,204}
\definecolor{citerullink}{RGB}{97, 159, 255}
\definecolor{resultscolor}{RGB}{10,21,68}
\definecolor{resultsbackground}{RGB}{219,229,241}
  
\RequirePackage[theorems,skins]{tcolorbox}                    % https://www.tug.org/docs/latex/tcolorbox/tcolorbox.pdf color finder: https://paletton.com/#uid=1000u0kllllaFw0g0qFqFg0w0aF use [many] for more options
\newtcolorbox{rb}{width=0.6\linewidth,math,center,halign=flush center,top=1mm,bottom=1mm,colback=resultsbackground,colframe=resultscolor}
\newtcolorbox{rba}{width=0.6\linewidth,ams align*,center,halign=flush center,top=1mm,bottom=1mm,colback=resultsbackground,colframe=resultscolor}
\newtcolorbox{rbl}{width=\linewidth,math,center,halign=flush center,top=1mm,bottom=1mm,colback=resultsbackground,colframe=resultscolor}
\newtcolorbox{rbla}{width=\linewidth,ams align*,center,halign=flush center,top=1mm,bottom=1mm,colback=resultsbackground,colframe=resultscolor}
\newtcolorbox{prb}{width=0.6\linewidth,math,center,halign=flush center,top=1mm,bottom=1mm,colback=white,colframe=resultscolor}
\newtcolorbox{prba}{width=0.6\linewidth,ams align*,center,halign=flush center,top=1mm,bottom=1mm,colback=white,colframe=resultscolor}
\newtcolorbox{prbla}{width=\linewidth,ams align*,center,halign=flush center,top=1mm,bottom=1mm,colback=white,colframe=resultscolor}
\newtcolorbox{prbl}{width=\linewidth,math,center,halign=flush center,top=1mm,bottom=1mm,colback=white,colframe=resultscolor}
% to set inlinemath hightlight style \tcbhighmath
\tcbset{highlight math style={enhanced, colback={resultsbackground},colframe={resultscolor},left=0pt,right=0pt,top=0pt,bottom=0pt,extrude left by=0pt,extrude right by=0pt,extrude top by=1pt,extrude bottom by=1pt,boxsep=\fboxsep}}

\RequirePackage{booktabs}                           %\toprule, \midrule, \bottomrule
                                                % \cmidrule[x pt](l r{.75em}){1-3}  %<- macht nur unter Spalten 1-3 ne Linie mit Dicke x pt, wobei die Linie links default 0.5em getrimmt wird und rechts 0.75em)
                                                % \setlength{\cmidrulekern}{0.25em} % Globales anpassen des Trimmens, geht auch (cmidrulekern ist das Argument von l und r)
                                                % anstatt den default commands \hline, \cline(1-3)):
                                                % \setlength{\abovetopsep}{0.5em}   % provide space between caption and top rule
                                                % \setlength{\tabcolsep}{3.7pt}     % Anpassen der default Spaltenabstände

\RequirePackage[math,column=Q]{cellspace}
\RequirePackage{array}                              % Bsp:\newcolumntype{name}{definition} like simplest: \newcolumntype{C}{>{$}c<{$}} % macht Mathemodus-Spalten \href{https://tex.stackexchange.com/questions/257128/how-does-the-newcolumntype-command-work}
\RequirePackage{tabularx}                           % \href{https://tex.stackexchange.com/questions/341205/what-is-the-difference-between-tabular-tabular-and-tabularx-environments}
\RequirePackage{makecell}                           % \href{https://tex.stackexchange.com/questions/67047/not-enough-space-in-table-for-fractions}
\RequirePackage{arraycols}                          % https://ctan.math.utah.edu/ctan/tex-archive/macros/latex/contrib/arraycols/arraycols.pdf
\RequirePackage{multirow}
\RequirePackage{multicol}

\RequirePackage{wrapfig}
\RequirePackage{lipsum}
\RequirePackage{enumitem}

\RequirePackage[raiselinks=true,                    % package enables hyperlinks in document. 
            bookmarks=true,                     % hyperindex=true, option not given, because index package not needed yet
            bookmarksopenlevel=1,               
            bookmarksnumbered=true,
            pageanchor=true,
            plainpages=false,
            pdfpagelabels=true,
            pdfnewwindow=true,
            colorlinks=true,allcolors=.,citecolor=citerullink]{hyperref}
\hypersetup{urlcolor=blueurllink}               % set allcolors = . "." is eqv fontcolor. We exclude urlcolor. 
                                                % by manually using urlcolor=. in front of \printbib,--> the bibliography is uncolored.

\RequirePackage{cleveref}                           % \documentclass[ngerman/english] as a global option is passed down as loading option to cleverref. use \crefname{Typ}{Singular}{Plural}: \crefname{figure}{Abb.}{Abb.} \Crefname{figure}{Abb.}{Abb.} % Für den Satzanfang (\Cref), to change those prefix prints (Abbildung 1, Gleichung 1)
                                                % use \cref to rerence: https://www.namsu.de/Extra/pakete/Cleveref.html 
\RequirePackage{showkeys}                           % to show labels inside the compiled document
\setlength {\marginparwidth }{2cm}
\RequirePackage{todonotes}                        % supercool to insert todo reminders, that are displayed in the margins


%% --------------------------
%% |    Globale Settings    |
%% --------------------------
\setcounter{secnumdepth}{3}           % Numbering also for \subsubsections
\setcounter{tocdepth}{3}              % Register \subsubsections in content dir

\endinput
