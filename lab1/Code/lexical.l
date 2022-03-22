%{
    # include "syntax.tab.h"
    # include "node.h"

    int yycolumn = 1;

    //#define YY_USER_ACTION \
        yylloc.first_line = yylloc.last_line = yylineno; \
        yylloc.first_column = yycolumn; \
        yylloc.last_column = yycolumn + yyleng - 1; \
        yycolumn += yyleng;
    
%}

ws [ \t]+
digit [0-9]
letter [_a-zA-Z]

INT 0|[1-9]{digit}*
FLOAT {digit}+.{digit}+|{digit}*\.{digit}+[eE][+-]?{digit}+
ID {letter}({letter}|{digit})*
SEMI ";"
COMMA ","
ASSIGNOP "="
RELOP "<"|"<="|">"|">="|"=="|"!="
PLUS "+"
MINUS "-"
STAR "*"
DIV "/"
AND "&&"
OR "||"
NOT "!"
DOT "."
TYPE int|float
LP "("
RP ")"
LB "["
RB "]"
LC "{"
RC "}"
STRUCT struct
RETURN return
IF if
ELSE else
WHILE while

%%

{ws} {}
\n|\r { yycolumn = 1; }

{IF} { yylaval = Node(NULL, "IF"); return IF; }
{ELSE} { yylaval = Node(NULL, "ELSE"); return ELSE; }
{WHILE} { yylaval = Node(NULL, "WHILE"); return WHILE; }
{TYPE} { yylaval = Node(NULL, "TYPE", yytext); return TYPE; }
{STRUCT} { yylaval = Node(NULL, "STRUCT"); return STRUCT; }
{RETURN} { yylaval = Node(NULL, "RETURN"); return RETURN; }
{RELOP} { yylaval = Node(NULL, "RELOP"); return RELOP; }

{PLUS} { yylaval = Node(NULL, "PLUS"); return PLUS; }
{MINUS} { yylaval = Node(NULL, "MINUS"); return MINUS; }
{STAR} { yylaval = Node(NULL, "STAR"); return STAR; }
{DIV} { yylaval = Node(NULL, "DIV"); return DIV; }
{AND} { yylaval = Node(NULL, "AND"); return AND; }
{OR} { yylaval = Node(NULL, "OR"); return OR; }
{NOT} { yylaval = Node(NULL, "NOT"); return NOT; }

{DOT} { yylaval = Node(NULL, "DOT"); return DOT; }
{SEMI} { yylaval = Node(NULL, "SEMI"); return SEMI; }
{COMMA} { yylaval = Node(NULL, "COMMA"); return COMMA; }
{ASSIGNOP} { yylaval = Node(NULL, "ASSIGNOP"); return ASSIGNOP; }

{LP} { yylaval = Node(NULL, "LP\n"); return LP; }
{RP} { yylaval = Node(NULL, "RP\n"); return RP; }
{LB} { yylaval = Node(NULL, "LB\n"); return LB; }
{RB} { yylaval = Node(NULL, "RB\n"); return RB; }
{LC} { yylaval = Node(NULL, "LC\n"); return LC; }
{RC} { yylaval = Node(NULL, "RC\n"); return RC; }

{ID} { yylaval = Node(NULL, "ID", yytext); return ID; }
{INT} { yylaval = Node(NULL, atoi(yytext)); return INT; }
{FLOAT} { yylaval = Node(NULL, atof(yytext)); return FLOAT; }


. { printf("Error type A at Line %d: Mysterious characters \'%s\'\n", yylineno, yytext); }

%%

//{user subroutines}