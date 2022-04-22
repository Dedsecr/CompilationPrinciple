#ifndef INTERIM_H
#define INTERIM_H

#include <stdarg.h>

#include "semantic.h"

#define INTERCODE_1 1
#define INTERCODE_2 2
#define INTERCODE_3 3
#define INTERCODE_IF 4
#define INTERCODE_DEC 12
#define OPERAND_NULL -1

typedef struct Operand* OperandP;
typedef struct InterCode* InterCodeP;

// VARIABLE普通函数参数,char+int
//先查询符号表中是否以及给该变量var值
// TEMP临时变量
// CONSTANT常数
// ADDRESS数组做为函数参数char+int
// WADDRESS写入地址，
enum KindOperand {
    VARIABLE,
    TEMP,
    CONSTANT,
    ADDRESS,
    FUNCTION,
    LABEL,
    RELOP
};

// PARAM打印param v+id
// ASSIGN打印：注意立即数
// ADDRASS2打印：t2=*t1
// ADDRADD3其实是在赋值语句中，如果左为address,右为其他的话
// ARG打印：如果address就&，不是则正常
enum KindInterCode {
    ILABEL,
    IFUNCTION,
    ASSIGN,
    ADD,
    SUB,
    MUL,
    DIV,
    ADDRASS1,
    ADDRASS2,
    ADDRASS3,
    GOTO,
    IF,
    RETURN,
    DEC,
    ARG,
    CALL,
    PARAM,
    READ,
    WRITE
};

struct Operand {
    enum KindOperand kind;
    int id;
    char* u_char;
    TypeP type;  // for offset
};

struct InterCode {
    enum KindInterCode kind;
    // LABEL,FUNCTION,GOTO,RETURN,ARG
    // PARAM,READ,WRITE
    struct {
        OperandP op;
    } ulabel;
    // ASSIGN,CALL
    // ADDRASS1,ADDRASS2,ADDRASS3
    struct {
        OperandP op1, op2;
    } uassign;
    // ADD,SUB,MUL,DIV
    struct {
        OperandP result, op1, op2;
    } ubinop;
    // IF
    struct {
        OperandP x, relop, y, z;
    } uif;
    // DEC
    struct {
        OperandP op;
        int size;
    } udec;
    InterCodeP prev, next;
};

OperandP create_operand(enum KindOperand kind, int id, char* u_char, TypeP type);
InterCodeP create_intercode(enum KindInterCode kind, int intercode_type, ...);
OperandP creat_temp();
OperandP creat_label();
void insert_intercode(InterCodeP this);

void translate_print_test(InterCodeP temp);
void translate_print(FILE* f);
void translate_Program(NodeP x, FILE* F);
void translate_ExtDefList(NodeP x);
void translate_ExtDef(NodeP x);
void translate_FunDec(NodeP x);
void translate_CompSt(NodeP x);
void translate_DefList(NodeP x);
void translate_StmtList(NodeP x);
void translate_Def(NodeP x);
void translate_Stmt(NodeP x);
void translate_DecList(NodeP x);
void translate_Exp(NodeP x, OperandP place);
void translate_CompSt(NodeP x);
void translate_Cond(NodeP x, OperandP lt, OperandP lf);
void translate_Dec(NodeP x);
void translate_VarDec(NodeP x, OperandP place);
void translate_Args(NodeP x, InterCodeP prev);

int get_offset(TypeP return_type);
int get_size(TypeP type);

#endif