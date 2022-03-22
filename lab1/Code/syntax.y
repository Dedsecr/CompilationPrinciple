%{
    # include <stdio.h>
    # include "lex.yy.c"
    # include "node.h"
    
    Node root;
%}

%union {
    Node node;
}

// terminal symbols

%token <node> TYPE
%token <node> RETURN
%token <node> IF
%token <node> ELSE
%token <node> WHILE
%token <node> STRUCT
%token <node> INT
%token <node> FLOAT
%token <node> ID
%token <node> SEMI
%token <node> COMMA
%token <node> ASSIGNOP
%token <node> RELOP
%token <node> PLUS
%token <node> MINUS
%token <node> STAR
%token <node> DIV
%token <node> AND
%token <node> OR
%token <node> NOT
%token <node> DOT
%token <node> LP
%token <node> RP
%token <node> LB
%token <node> RB
%token <node> LC
%token <node> RC

// non-terminal symbols

%type <node> Program ExtDefList ExtDef ExtDecList
%type <node> Specifier StructSpecifier OptTag Tag
%type <node> VarDec FunDec VarList ParamDec
%type <node> CompSt StmtList Stmt
%type <node> DefList Def DecList Dec
%type <node> Exp Args

%right ASSIGNOP
%left OR
%left AND
%left RELOP
%left PLUS MINUS
%left STAR DIV
%right NOT
%left DOT LB RB LP RP

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%%

// High-level Definitions
Program : ExtDefList { $$ = Node(@$.first_line, 1, $1); root = $$; }
    ;
ExtDefList : ExtDef ExtDefList { $$ = Node(@$.first_line, 2, $1, $2); }
    |   { $$ = NULL; }
    ;
ExtDef : Specifier ExtDecList SEMI { $$ = Node(@$.first_line, 3, $1, $2, ); }
    | Specifier SEMI { $$ = Node(@$.first_line, 1, $1); }
    | Specifier FunDec CompSt { $$ = Node(@$.first_line, 1, $1); }
    ;
ExtDecList : VarDec { $$ = Node(@$.first_line, 1, $1); }
    | VarDec COMMA ExtDecList { $$ = Node(@$.first_line, 1, $1); }
    ;

// Specifiers
Specifier : TYPE { $$ = Node(@$.first_line, 1, $1); }
    | StructSpecifier { $$ = Node(@$.first_line, 1, $1); }
    ;
StructSpecifier : STRUCT OptTag LC DefList RC { $$ = Node(@$.first_line, 1, $1); }
    | STRUCT Tag { $$ = Node(@$.first_line, 1, $1); }
    ;
OptTag : ID { $$ = Node(@$.first_line, 1, $1); }
    | { $$ = Node(@$.first_line, 1, $1); }
    ;
Tag : ID { $$ = Node(@$.first_line, 1, $1); }
    ;

// Declarators
VarDec : ID { $$ = Node(@$.first_line, 1, $1); }
    | VarDec LB INT RB { $$ = Node(@$.first_line, 1, $1); }
    ;
FunDec : ID LP VarList RP { $$ = Node(@$.first_line, 1, $1); }
    | ID LP RP { $$ = Node(@$.first_line, 1, $1); }
    ;
VarList : ParamDec COMMA VarList { $$ = Node(@$.first_line, 1, $1); }
    | ParamDec { $$ = Node(@$.first_line, 1, $1); }
    ;
ParamDec : Specifier VarDec { $$ = Node(@$.first_line, 1, $1); }
    ;

// statements
CompSt : LC DefList StmtList RC { $$ = Node(@$.first_line, 1, $1); }
    ;
StmtList : Stmt StmtList { $$ = Node(@$.first_line, 1, $1); }
    | { $$ = Node(@$.first_line, 1, $1); }
    ;
Stmt : Exp SEMI { $$ = Node(@$.first_line, 1, $1); }
    | CompSt { $$ = Node(@$.first_line, 1, $1); }
    | RETURN Exp SEMI { $$ = Node(@$.first_line, 1, $1); }
    | IF LP Exp RP Stmt %prec LOWER_THAN_ELSE { $$ = Node(@$.first_line, 1, $1); }
    | IF LP Exp RP Stmt ELSE Stmt { $$ = Node(@$.first_line, 1, $1); }
    | WHILE LP Exp RP Stmt { $$ = Node(@$.first_line, 1, $1); }
    ;

// Local Definitions
DefList : Def DefList { $$ = Node(@$.first_line, 1, $1); }
    | { $$ = Node(@$.first_line, 1, $1); }
    ;
Def : Specifier DecList SEMI { $$ = Node(@$.first_line, 1, $1); }
    ;
DecList : Dec { $$ = Node(@$.first_line, 1, $1); }
    | Dec COMMA DecList { $$ = Node(@$.first_line, 1, $1); }
    ;
Dec : VarDec { $$ = Node(@$.first_line, 1, $1); }
    | VarDec ASSIGNOP Exp { $$ = Node(@$.first_line, 1, $1); }
    ;

// Expressions
Exp : Exp ASSIGNOP Exp { $$ = Node(@$.first_line, 1, $1); }
    | Exp AND Exp { $$ = Node(@$.first_line, 1, $1); }
    | Exp OR Exp { $$ = Node(@$.first_line, 1, $1); }
    | Exp RELOP Exp { $$ = Node(@$.first_line, 1, $1); }
    | Exp PLUS Exp { $$ = Node(@$.first_line, 1, $1); }
    | Exp MINUS Exp { $$ = Node(@$.first_line, 1, $1); }
    | Exp STAR Exp { $$ = Node(@$.first_line, 1, $1); }
    | Exp DIV Exp { $$ = Node(@$.first_line, 1, $1); }
    | LP Exp RP { $$ = Node(@$.first_line, 1, $1); }
    | MINUS Exp { $$ = Node(@$.first_line, 1, $1); }
    | NOT Exp { $$ = Node(@$.first_line, 1, $1); }
    | ID LP Args RP { $$ = Node(@$.first_line, 1, $1); }
    | ID LP RP { $$ = Node(@$.first_line, 1, $1); }
    | Exp LB Exp RB { $$ = Node(@$.first_line, 1, $1); }
    | Exp DOT ID { $$ = Node(@$.first_line, 1, $1); }
    | ID { $$ = Node(@$.first_line, 1, $1); }
    | INT { $$ = Node(@$.first_line, 1, $1); }
    | FLOAT { $$ = Node(@$.first_line, 1, $1); }
    ;
Args : Exp COMMA Args { $$ = Node(@$.first_line, 1, $1); }
    | Exp { $$ = Node(@$.first_line, 1, $1); }
    ;

%%

yyerror(char* msg) {
    fprintf(stderr, "Error type B at line %d: %s.\n", yylineno, msg);
}