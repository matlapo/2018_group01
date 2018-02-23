%{
%}
%token TVAR
%token TIF
%token <string> TIDENTIFIER
%token TINT
%token TFLOAT
%token TSTRING
%token TBOOLEAN
%token TPRINT
%token TPRINTLN
%token TAPPEND
%token TELSE
%token TTRUE
%token TFALSE
%token <int> TINTVAL
%token <float> TFLOATVAL
%token <string> TSTRINGVAL
%token <int> TOCTOVAL
%token <string> THEXVAL
%token TPLUS
%token TMINUS
%token TTIMES
%token TDIV
%token TEQUALS
%token TNOT
%token TASSIGN
%token TNOTEQUAL
%token TAND
%token TOR
%token TBITAND
%token TBITOR
%token TPLUSEQUAL
%token TMINUSEQUAL
%token TMULTEQUAL
%token TDIVEQUAL
%token TANDEQUAL
%token TOREQUAL
%token THATEQUAL
%token TPERCENTEQUAL
%token TGREATER
%token TSMALLER
%token TGREATEREQ
%token TSMALLEREQ
%token TDGREATER
%token TDSMALLER
%token TLEFTARROW
%token TDGEQUAL
%token TDSEQUAL
%token TDPLUS
%token TDMINUS
%token TCOLEQUAL
%token TANDHAT
%token TWTF
%token TCOLON
%token TSEMICOLON
%token TCOMMA
%token TPERIOD
%token TDOTS
%token TOPENINGBRACE
%token TCLOSINGBRACE
%token TOPENINGBRACKET
%token TCLOSINGBRACKET
%token TOPENINGSQUARE
%token TCLOSINGSQUARE
%token EOF
%token TBREAK
%token TCASE 
%token TCHAN
%token TCONST
%token TCONTINUE
%token TDEFAULT
%token TDEFER 
%token TFALL 
%token TFOR 
%token TFUNC 
%token TGO 
%token TGOTO 
%token TIMPORT 
%token TIFACE 
%token TMAP 
%token TPACKAGE 
%token TRANGE 
%token TRETURN 
%token TSELECT 
%token TSTRUCT 
%token TSWITCH 
%token TTYPE

%start <string> prog
%%

prog:
  | EOF         { "" }
  | v = stmt    { v }
  ;

stmt:
  | v1 = value v2 = stmt  { v1 ^ "\n" ^ v2 }
  | v = value EOF         { v }

value:
  | TPRINT            { "TPRINT" }
  | TPRINTLN          { "TPRINTLN" }
  | TAPPEND           { "TAPPEND" }
  | TVAR              { "TVAR" }
  | TIF               { "TIF" }
  | TELSE             { "TELSE" }
  | TBREAK            { "TBREAK" }
  | TCASE             { "TCASE" }
  | TCHAN             { "TCHAN" }
  | TCONST            { "TCONST" }
  | TCONTINUE         { "TCONTINUE" }
  | TDEFAULT          { "TDEFAULT" }
  | TDEFER            { "TDEFER" }
  | TFALL             { "TFALL" }
  | TFOR              { "TFOR" }
  | TFUNC             { "TFUNC" }
  | TGO               { "TGO" }
  | TGOTO             { "TGOTO" }
  | TIMPORT           { "TIMPORT" }
  | TIFACE            { "TIFACE" }
  | TMAP              { "TMAP" }
  | TPACKAGE          { "TPACKAGE" }
  | TRANGE            { "TRANGE" }
  | TRETURN           { "TRETURN" }
  | TSELECT           { "TSELECT" }
  | TSTRUCT           { "TSTRUCT" }
  | TSWITCH           { "TSWITCH" }
  | TTYPE             { "TTYPE" }
  | TTRUE             { "TTRUE" }
  | TFALSE            { "TFALSE" }
  | i = TINTVAL       { "TINTVAL(" ^ string_of_int i ^ ")"  }
  | f = TFLOATVAL     { "TFLOATVAL(" ^ string_of_float f ^ ")" }
  | s = TSTRINGVAL    { "TSTRINGVAL(" ^ s ^ ")" }
  | h = THEXVAL       { "THEXVAL(" ^ h ^ ")" }
  | o = TOCTOVAL      { "TOCTOVAL(" ^ string_of_int o ^ ")" }
  | TPLUS             { "TPLUS" }
  | TMINUS            { "TMINUS" }
  | TTIMES            { "TTIMES" }
  | TDIV              { "TDIV" }
  | TNOT              { "TNOT" }
  | TEQUALS           { "TEQUALS" }
  | TASSIGN           { "TASSIGN" }
  | TNOTEQUAL         { "TNOTEQUAL" }
  | TAND              { "TAND" }
  | TOR               { "TOR" }
  | TBITAND           { "TBITAND" }
  | TBITOR            { "TBITOR" }
  | TPLUSEQUAL        { "TPLUSEQUAL" }
  | TMINUSEQUAL       { "TMINUSEQUAL" }
  | TMULTEQUAL        { "TMULTEQUAL" }
  | TDIVEQUAL         { "TDIVEQUAL" }
  | TANDEQUAL         { "TANDEQUAL" }
  | TOREQUAL          { "TOREQUAL" }
  | THATEQUAL         { "THATEQUAL" }
  | TPERCENTEQUAL     { "TPERCENTEQUAL" }
  | TGREATER          { "TGREATER" }
  | TSMALLER          { "TSMALLER" }
  | TGREATEREQ        { "TGREATEREQ" }
  | TSMALLEREQ        { "TSMALLEREQ" }
  | TDSMALLER         { "TDSMALLER" }
  | TDGREATER         { "TDGREATER" }
  | TLEFTARROW        { "TLEFTARROW" }
  | TDGEQUAL          { "TDGEQUAL" }
  | TDSEQUAL          { "TDSEQUAL" }
  | TDPLUS            { "TDPLUS" }
  | TDMINUS           { "TDMINUS" }
  | TCOLEQUAL         { "TCOLEQUAL" }
  | TANDHAT           { "TANDHAT" }
  | TWTF              { "WTF" }
  | TCOLON            { "TCOLON" }
  | TSEMICOLON        { "TSEMICOLON" }
  | TCOMMA            { "TCOMMA" }
  | TPERIOD           { "TPERIOD" }
  | TDOTS             { "TDOTS" }
  | TOPENINGSQUARE    { "TOPENINGSQUARE" }
  | TCLOSINGSQUARE    { "TCLOSINGSQUARE" }
  | TOPENINGBRACE     { "TOPENINGBRACE" }
  | TCLOSINGBRACE     { "TCLOSINGBRACE" }
  | TOPENINGBRACKET   { "TOPENINGBRACKET" }
  | TCLOSINGBRACKET   { "TCLOSINGBRACKET" }
  | TINT              { "TINT" }
  | TFLOAT            { "TFLOAT" }
  | TSTRING           { "TSTRING" }
  | TBOOLEAN          { "TBOOLEAN" }
  | id = TIDENTIFIER  { "TIDENTIFIER(" ^ id ^ ")" }
  ;