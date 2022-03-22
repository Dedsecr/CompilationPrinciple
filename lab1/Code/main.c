#include <stdio.h>
#include "node.h"

extern NodeP root;
// extern int yydebug;

unsigned lexError = 0, synError = 0;

int main(int argc, char **argv)
{
    if (argc <= 1)
        return 1;

    FILE *f = fopen(argv[1], "r");
    if (!f)
    {
        perror(argv[1]);
        return 1;
    }

    // yydebug = 1;
    yyrestart(f);
    yyparse();
    if (!lexError && !synError)
        print_node_tree(root, 0);
    return 0;
}
