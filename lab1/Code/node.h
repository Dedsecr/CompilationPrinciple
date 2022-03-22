#include <stdarg.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <string>

const int MAX_CHILD_NUM = 10;
#define NONTERMINAL_NODE 0
#define TERMINAL_NODE_INT 1
#define TERMINAL_NODE_FLOAT 2
#define TERMINAL_NODE_STRING 3
#define TERMINAL_NODE_TYPE_OR_ID 4

struct Node
{
    int data_int, child_num, line;
    short type;
    float data_float;
    std::string data_string, data_string_data;
    Node *children[MAX_CHILD_NUM];

    Node() {}
    Node(int line, int child_num, ...)
    {
        va_list valist;

        this->type = NONTERMINAL_NODE;
        this->child_num = child_num;

        va_start(valist, child_num);
        for (int i = 0; i < child_num; i++)
        {
            this->children[i] = va_arg(valist, Node *);
        }
        va_end(valist);
    }
    Node(int line, Node *child, float data_float)
    {
        assert(child == NULL);
        this->type = TERMINAL_NODE_INT;
        this->child_num = 0;
        this->data_float = data_float;
    }
    Node(int line, Node *child, int data_int)
    {
        assert(child == NULL);
        this->type = TERMINAL_NODE_FLOAT;
        this->child_num = 0;
        this->data_int = data_int;
    }
    Node(int line, Node *child, std::string data_string)
    {
        assert(child == NULL);
        this->type = TERMINAL_NODE_STRING;
        this->child_num = 0;
        this->data_string = data_string;
    }
    Node(int line, Node *child, int type, std::string data_string, std::string data_string_data)
    {
        assert(child == NULL);
        this->type = TERMINAL_NODE_TYPE_OR_ID;
        this->child_num = 0;
        this->data_string = data_string;
        this->data_string_data = data_string_data;
    }
};

void print_node_tree(Node *root, int level)
{
    if (root == NULL)
        return;

    for (int i = 0; i < level; i++)
        printf("  ");

    if (root->type == NONTERMINAL_NODE)
    {
        printf("%s (%d)\n", root->data_string.c_str(), root->line);
        for (int i = 0; i < root->child_num; i++)
            print_node_tree(root->children[i], level + 1);
    }
    else if (root->type == TERMINAL_NODE_INT)
    {
        printf("INT: %d\n", root->data_int);
    }
    else if (root->type == TERMINAL_NODE_FLOAT)
    {
        printf("FLOAT: %f\n", root->data_float);
    }
    else if (root->type == TERMINAL_NODE_STRING)
    {
        printf("%s\n", root->data_string.c_str());
    }
    else if (root->type == TERMINAL_NODE_TYPE_OR_ID)
    {
        printf("%s: %s\n", root->data_string.c_str(), root->data_string_data.c_str());
    }
}