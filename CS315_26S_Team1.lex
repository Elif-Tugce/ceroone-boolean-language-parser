%{
#include <stdio.h>
#include "y.tab.h"

int line_num = 1;
%}

%option noyywrap
%x COMMENTSTATE

LETTER      [A-Za-z]
DIGIT       [0-9]
IDCHAR      [A-Za-z0-9_$]
IDENT       {LETTER}{IDCHAR}*
STRING      \"[^\n"]*\"

%%

"func"                  { return FUNC; }
"void"                  { return VOID; }
"return"                { return RETURN; }

"if"                    { return IF; }
"else"                  { return ELSE; }
"elif"                  { return ELIF; }

"switch"                { return SWITCH; }
"case"                  { return CASE; }
"default"               { return DEFAULT; }

"while"                 { return WHILE; }
"for"                   { return FOR; }
"in"                    { return IN; }

"input"                 { return INPUT; }
"print"                 { return PRINT; }

"bool"                  { return BOOL_TYPE; }
"true"                  { return TRUE_CONST; }
"false"                 { return FALSE_CONST; }
"nil"                   { return NIL; }

"xor"                   { return XOR; }
"isEmpty"               { return ISEMPTY_FUNC; }
"head"                  { return HEAD_FUNC; }
"tail"                  { return TAIL_FUNC; }
"cons"                  { return CONS_FUNC; }

"<=>"                   { return BICONDITIONAL_OP; }
"=>"                    { return IMPLICATION_OP; }
"=="                    { return EQ_OP; }
"!="                    { return NEQ_OP; }
"||"                    { return OR_OP; }
"&&"                    { return AND_OP; }

"="                     { return ASSIGN_OP; }
"!"                     { return NOT_OP; }
"*"                     { return STAR; }

"("                     { return LP; }
")"                     { return RP; }
"{"                     { return LB; }
"}"                     { return RB; }
"["                     { return LSB; }
"]"                     { return RSB; }

","                     { return COMMA; }
";"                     { return SEMICOLON; }
":"                     { return COLON; }

"//"[^\n]*              { return COMMENT; }

"/*"                    { BEGIN(COMMENTSTATE); }
<COMMENTSTATE>"*/"      { BEGIN(INITIAL); return COMMENT; }
<COMMENTSTATE>\n        { line_num++; }
<COMMENTSTATE>.         { }

{STRING}                { return STRING_LITERAL; }
{IDENT}                 { return IDENTIFIER; }

[ \t\r]+                { }
\n                      { line_num++; }

.                       { return yytext[0]; }

%%