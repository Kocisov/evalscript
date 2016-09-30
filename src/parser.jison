%lex
%%

\s+                                   /* skip whitespace */
"//".*                                /* Ignore */
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]   /* Ignore */

'eval'                                return 'EVAL'
'log'                                 return 'LOG'
'true'                                return 'TRUE'
'false'                               return 'FALSE'
'from'                                return 'FROM'
'get'                                 return 'GET'
'use'                                 return 'USE'

(['](\\.|[^']|\\\')*?['])+            return 'STRING'
(["](\\.|[^"]|\\\")*?["])+            return 'STRING'

'@'                                   return 'AT'
'{'                                   return 'LEFT_UBRACE'
'}'                                   return 'RIGHT_UBRACE'
'('                                   return 'LEFT_BRACE'
')'                                   return 'RIGHT_BRACE'
'['                                   return 'LEFT_HBRACE'
']'                                   return 'RIGHT_HBRACE'
'=['                                  return 'E_RHBRACE'
'<='                                  return 'LEFT_DOUBLE_ARROW'
'=>'                                  return 'RIGHT_DOUBLE_ARROW'
'='                                   return 'EQUAL'
'!='                                  return 'NOT_EQUAL'
'<-'                                  return 'LEFT_ARROW'
'->'                                  return 'RIGHT_ARROW'
'!'                                   return 'EX_MARK'
'?'                                   return 'QU_MARK'
'+'                                   return 'PLUS'
'-'                                   return 'MINUS'
'*'                                   return 'STAR'
'/'                                   return 'SLASH'
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
  : statements EOF
    {
      return yy.MainExpression($1)
    }
  ;

statements
  : statement
    {
      $$ = $1
    }
  | statements statement
    {
      $$ = $1.concat($2)
    }
  ;

statement
  : EVAL LOG logTypes
    {
      $$ = yy.LogExpression(@2, $3)
    }
  | EVAL VAR EQUAL textTypes
    {
      $$ = yy.AddVarExpression($2, $4)
    }
  | AT VAR LEFT_HBRACE functionInputs RIGHT_HBRACE LEFT_UBRACE statements RIGHT_UBRACE
    {
      $$ = yy.FunctionExpression($2, $4, $7)
    }
  | EVAL LEFT_BRACE VAR RIGHT_BRACE LEFT_UBRACE statements RIGHT_UBRACE
    {
      $$ = yy.IfExpression($3, $6)
    }
  | VAR LEFT_BRACE functionInputs RIGHT_BRACE
    {
      $$ = yy.FunctionExpression($1, $3, 'call')
    }
  | EVAL VAR LEFT_HBRACE objectTypes RIGHT_HBRACE
    {
      $$ = yy.CreateFObject($2, $4)
    }
  | EVAL textTypes FROM STRING
    {
      $$ = yy.ImportExpression($2, $4)
    }
  | EVAL DOT USE textTypes
    {
      $$ = yy.Use($4)
    }
  | EVAL VAR
    {
      $$ = yy.ExportExpression($2)
    }
  ;

logTypes
  : textTypes
    {
      $$ = $1
    }
  ;

objectTypes
  : textTypes
    {
      $$ = $1
    }
  | objectTypes textTypes
    {
      $$ = $1 + ',' + $2
    }
  ;

textTypes
  : STRING
    {
      $$ = $1
    }
  | VAR
    {
      $$ = $1
    }
  | NUMBER
    {
      $$ = $1
    }
  /* rethink */
  | TRUE
    {
      $$ = $1
    }
  | FALSE
    {
      $$ = $1
    }
  ;

functionInputs
  : textTypes
    {
      $$ = $1
    }
  | functionInputs textTypes
    {
      $$ = $1 + ',' + $2
    }
  | EX_MARK
    {
      $$ = 'noInput'
    }
  ;

%%
