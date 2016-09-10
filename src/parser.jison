%lex
%%

\s+                                /* skip whitespaces */
'eval'                             return 'EVAL'
'log'                              return 'LOG'
'='                                return 'EQUAL'

(['](\\.|[^']|\\\')*?['])+         return 'STRING'
(["](\\.|[^"]|\\\")*?["])+         return 'STRING'

[0-9]+("."[0-9]+)?\b               return 'NUMBER'
[_a-zA-Z]+[_a-zA-Z0-9]*\b          return 'VAR'

<<EOF>>                            return 'EOF'

/lex

%start program
%% /* language grammar */

program
  : statements EOF {
    return yy.MainExpression($1)
  }
;

statements
  : statement {
    $$ = $1
  }
  | statements statement {
    $$ = $1.concat($2)
  }
;

statement
  : EVAL LOG logTypes {
    $$ = yy.LogExpression(@2, $3)
  }
  | EVAL VAR EQUAL textTypes {
    $$ = yy.AddVarExpression($2, $4)
  }
;

logTypes
  : textTypes {
    $$ = $1
  }
;

textTypes
  : STRING {
    $$ = $1
  }
  | VAR {
    $$ = $1
  }
  | NUMBER {
    $$ = $1
  }
;

%%
