%{
    # include "syntax.tab.h"
%}

digit [0-9]
letter [_a-zA-Z]

INT 0|[1-9]{digit}*
FLOAT {digit}+.{digit}+|{digit}*\.{digit}+[eE][+-]?{digit}+
ID {letter}[{letter}{digit}]*
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

{FLOAT}+ {printf("Float Value: %f\n", atof(yytext)); return FLOAT;}
{ID}+ {printf("ID Value: %s\n", yytext); return ID;}
{SEMI} {printf("SEMI\n"); return SEMI;}
{COMMA} {printf("COMMA\n"); return COMMA;}
{ASSIGNOP} {printf("ASSIGNOP\n"); return ASSIGNOP;}
{RELOP} {printf("RELOP\n"); return RELOP;}
{PLUS} {printf("PLUS\n"); return PLUS;}
{MINUS} {printf("MINUS\n"); return MINUS;}
{STAR} {printf("STAR\n"); return STAR;}
{DIV} {printf("DIV\n"); return DIV;}
{AND} {printf("AND\n"); return AND;}
{OR} {printf("OR\n"); return OR;}
{NOT} {printf("NOT\n"); return NOT;}
{DOT} {printf("DOT\n"); return DOT;}
{LP} {printf("LP\n"); return LP;}
{RP} {printf("RP\n"); return RP;}
{LB} {printf("LB\n"); return LB;}
{RB} {printf("RB\n"); return RB;}
{LC} {printf("LC\n"); return LC;}
{RC} {printf("RC\n"); return RC;}
{TYPE} {printf("TYPE\n"); return TYPE;}
{RETURN} {printf("RETURN\n"); return RETURN;}
{IF} {printf("IF\n"); return IF;}
{ELSE} {printf("ELSE\n"); return ELSE;}
{WHILE} {printf("WHILE\n"); return WHILE;}
{STRUCT} {printf("STRUCT\n"); return STRUCT;}
. {printf("error\n");}

%%

//{user subroutines}