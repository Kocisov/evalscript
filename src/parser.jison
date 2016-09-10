%lex
%%

\s+                                   /* skip whitespace */
"//".*                                /* Ignore */
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]   /* Ignore */

'eval'                                return 'EVAL'
'log'                                 return 'LOG'

(['](\\.|[^']|\\\')*?['])+            return 'STRING'
(["](\\.|[^"]|\\\")*?["])+            return 'STRING'

'@'                                   return 'AT'
'{'                                   return 'LEFT_UBRACE'
'}'                                   return 'RIGHT_UBRACE'
'('                                   return 'LEFT_BRACE'
')'                                   return 'RIGHT_BRACE'
'['                                   return 'LEFT_HBRACE'
']'                                   return 'RIGHT_HBRACE'
/* '=['                                  return '=[' */
'=>'                                  return 'DOUBLE_ARROW'
'='                                   return 'EQUAL'
'!='                                  return 'NOT_EQUAL'
'->'                                  return 'ARROW'
'!'                                   return 'EX_MARK'
'?'                                   return 'QU_MARK'
'+'                                   return 'PLUS'
'-'                                   return 'MINUS'
'*'                                   return 'STAR'
'/'                                   return 'SLASH'
/* [\\]                                  return 'BACK_SLASH' */
'<'                                   return 'LEFT_AR'
'>'                                   return 'RIGHT_AR'
','                                   return 'COMMA'
'.'                                   return 'DOT'
':'                                   return 'DOUBLE_DOT'
';'                                   return 'SEMICOLON'

[0-9]+("."[0-9]+)?\b                  return 'NUMBER'
[_a-zA-Z]+[_a-zA-Z0-9]*\b             return 'VAR'

<<EOF>>                               return 'EOF'

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
  | AT VAR LEFT_HBRACE functionInputs RIGHT_HBRACE LEFT_UBRACE statements RIGHT_UBRACE {
    $$ = yy.FunctionExpression($2, $4, $7)
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

functionInputs
  : textTypes {
    $$ = $1
  }
  | functionInputs textTypes {
    $$ = $1 + ',' + $2
  }
  | EX_MARK {
    $$ = 'noInput'
  }
;

%%
