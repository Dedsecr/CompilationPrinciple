digit [0-9]
letter [_a-zA-Z]

INT 0|[1-9]{digit}*
FLOAT {digit}+.{digit}+|{digit}*\.{digit}+[eE][+-]?{digit}+
ID {letter}[{letter}{digit}]*
SEMI ;
COMMA ,
ASSIGNOP =
RELOP <|>|<=|>=|==|!=
PLUS +
MINUS -
STAR *
DIV /
AND &&
OR ||
NOT !
DOT .
TYPE int|float
LP (
RP )
LB [
RB ]
LC {
RC }
STRUCT struct
RETURN return
IF if
ELSE else
WHILE while

%%

{digit}+ {printf("Interger Value: %d\n", atoi(yytext));} 
{FLOAT}+ {printf("Float Value: %f\n", atof(yytext));}
{ID}+ {printf("ID Value: %s\n", yytext);}
{SEMI} {printf("SEMI\n");}
{COMMA} {printf("COMMA\n");}
{ASSIGNOP} {printf("ASSIGNOP\n");}
{RELOP} {printf("RELOP\n");}
{PLUS} {printf("PLUS\n");}
{MINUS} {printf("MINUS\n");}
{STAR} {printf("STAR\n");}
{DIV} {printf("DIV\n");}
{AND} {printf("AND\n");}
{OR} {printf("OR\n");}
{NOT} {printf("NOT\n");}
{DOT} {printf("DOT\n");}
{LP} {printf("LP\n");}
{RP} {printf("RP\n");}
{LB} {printf("LB\n");}
{RB} {printf("RB\n");}
{LC} {printf("LC\n");}
{RC} {printf("RC\n");}
{TYPE} {printf("TYPE\n");}
{RETURN} {printf("RETURN\n");}
{IF} {printf("IF\n");}
{ELSE} {printf("ELSE\n");}
{WHILE} {printf("WHILE\n");}
{STRUCT} {printf("STRUCT\n");}
. {printf("error\n");}

%%

//{user subroutines}