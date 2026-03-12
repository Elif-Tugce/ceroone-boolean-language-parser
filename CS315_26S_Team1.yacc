%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
extern int line_num;
%}

%token FUNC VOID RETURN
%token IF ELSE ELIF
%token SWITCH CASE DEFAULT
%token WHILE FOR IN
%token INPUT PRINT

%token BOOL_TYPE
%token TRUE_CONST FALSE_CONST NIL

%token XOR
%token ISEMPTY_FUNC HEAD_FUNC TAIL_FUNC CONS_FUNC

%token BICONDITIONAL_OP IMPLICATION_OP EQ_OP NEQ_OP OR_OP AND_OP
%token ASSIGN_OP NOT_OP STAR

%token LP RP LB RB LSB RSB
%token COMMA SEMICOLON COLON

%token IDENTIFIER STRING_LITERAL COMMENT

%start program

%%

program
    : top_list
    ;

top_list
    : top_item
    | top_item top_list
    ;

top_item
    : func_def
    | stmt
    ;

func_def
    : FUNC ret_type IDENTIFIER LP param_list RP stmt_block
    | FUNC ret_type IDENTIFIER LP RP stmt_block
    ;

ret_type
    : VOID
    | type
    ;

return_stmt
    : RETURN SEMICOLON
    | RETURN expr SEMICOLON
    ;

param_list
    : param
    | param COMMA param_list
    ;

param
    : type IDENTIFIER
    ;

stmt_block
    : LB stmt_list RB
    | LB RB
    ;

stmt_list
    : stmt
    | stmt stmt_list
    ;

stmt
    : declaration_stmt
    | assign_stmt
    | if_stmt
    | switch_stmt
    | loop_stmt
    | io_stmt
    | return_stmt
    | func_call_stmt
    | COMMENT
    ;

declaration_stmt
    : type decl_list SEMICOLON
    ;

decl_list
    : declarator
    | declarator COMMA decl_list
    ;

declarator
    : IDENTIFIER
    | IDENTIFIER ASSIGN_OP init_expr
    ;

init_expr
    : expr
    ;

type
    : BOOL_TYPE
    | type STAR
    ;

ident_list
    : IDENTIFIER
    | IDENTIFIER COMMA ident_list
    ;

assign_stmt
    : IDENTIFIER ASSIGN_OP expr SEMICOLON
    ;

func_call_stmt
    : IDENTIFIER LP arg_list_opt RP SEMICOLON
    ;

if_stmt
    : IF LP expr RP stmt_block
    | IF LP expr RP stmt_block ELSE stmt_block
    | IF LP expr RP stmt_block elif_chain
    | IF LP expr RP stmt_block elif_chain ELSE stmt_block
    ;

elif_chain
    : elif_stmt
    | elif_stmt elif_chain
    ;

elif_stmt
    : ELIF LP expr RP stmt_block
    ;

switch_stmt
    : SWITCH LP expr RP LB case_list default_opt RB
    ;

case_list
    : case_clause
    | case_clause case_list
    ;

case_clause
    : CASE expr COLON stmt_block
    ;

default_opt
    : DEFAULT COLON stmt_block
    |
    ;

loop_stmt
    : while_stmt
    | for_stmt
    ;

while_stmt
    : WHILE LP expr RP stmt_block
    ;

for_stmt
    : FOR IDENTIFIER IN expr stmt_block
    ;

io_stmt
    : input_stmt
    | output_stmt
    ;

input_stmt
    : INPUT LP ident_list RP SEMICOLON
    ;

output_stmt
    : PRINT LP print_list RP SEMICOLON
    ;

print_list
    : print_arg
    | print_arg COMMA print_list
    ;

print_arg
    : STRING_LITERAL
    | expr
    ;

expr
    : biconditional_expr
    ;

biconditional_expr
    : implication_expr
    | biconditional_expr BICONDITIONAL_OP implication_expr
    ;

implication_expr
    : equality_expr
    | equality_expr IMPLICATION_OP implication_expr
    ;

equality_expr
    : or_expr
    | or_expr EQ_OP or_expr
    | or_expr NEQ_OP or_expr
    ;

or_expr
    : xor_expr
    | or_expr OR_OP xor_expr
    ;

xor_expr
    : and_expr
    | xor_expr XOR and_expr
    ;

and_expr
    : not_expr
    | and_expr AND_OP not_expr
    ;

not_expr
    : NOT_OP not_expr
    | primary_expr
    ;

primary_expr
    : bool_constant
    | NIL
    | LSB RSB
    | LSB expr_list RSB
    | CONS_FUNC LP expr COMMA expr RP
    | TAIL_FUNC LP expr RP
    | HEAD_FUNC LP expr RP
    | ISEMPTY_FUNC LP expr RP
    | LP expr RP
    | IDENTIFIER call_opt
    ;

call_opt
    : LP arg_list_opt RP
    |
    ;

arg_list_opt
    : arg_list
    |
    ;

arg_list
    : expr
    | expr COMMA arg_list
    ;

expr_list
    : expr
    | expr COMMA expr_list
    ;

bool_constant
    : TRUE_CONST
    | FALSE_CONST
    ;

%%

void yyerror(const char *s)
{
    printf("Syntax error on line %d\n", line_num);
}

int main(void)
{
    if (yyparse() == 0)
        printf("Input program is valid\n");
    return 0;
}