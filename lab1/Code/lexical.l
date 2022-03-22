%{
    # include "syntax.tab.h"

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

{ws} {printf("Blank\n");}
\n|\r {yycolumn = 1;}

{IF} {printf("IF\n"); return IF;}
{ELSE} {printf("ELSE\n"); return ELSE;}
{WHILE} {printf("WHILE\n"); return WHILE;}
{TYPE} {printf("TYPE\n"); return TYPE;}
{STRUCT} {printf("STRUCT\n"); return STRUCT;}
{RETURN} {printf("RETURN\n"); return RETURN;}
{RELOP} {printf("RELOP\n"); return RELOP;}

{PLUS} {printf("PLUS\n"); return PLUS;}
{MINUS} {printf("MINUS\n"); return MINUS;}
{STAR} {printf("STAR\n"); return STAR;}
{DIV} {printf("DIV\n"); return DIV;}
{AND} {printf("AND\n"); return AND;}
{OR} {printf("OR\n"); return OR;}
{NOT} {printf("NOT\n"); return NOT;}

{DOT} {printf("DOT\n"); return DOT;}
{SEMI} {printf("SEMI\n"); return SEMI;}
{COMMA} {printf("COMMA\n"); return COMMA;}
{ASSIGNOP} {printf("ASSIGNOP\n"); return ASSIGNOP;}

{LP} {printf("LP\n"); return LP;}
{RP} {printf("RP\n"); return RP;}
{LB} {printf("LB\n"); return LB;}
{RB} {printf("RB\n"); return RB;}
{LC} {printf("LC\n"); return LC;}
{RC} {printf("RC\n"); return RC;}

{ID} {printf("ID Value: %s\n", yytext); return ID;}
{INT} {printf("INT Value: %d\n", atoi(yytext)); return INT;}
{FLOAT} {printf("Float Value: %f\n", atof(yytext)); return FLOAT;}


. {printf("Error type A at Line %d: Mysterious characters \'%s\'\n", yylineno, yytext);}

%%

//{user subroutines}