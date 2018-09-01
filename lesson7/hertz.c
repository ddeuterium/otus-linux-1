#include <stdio.h>
#include <unistd.h>

int main()
{
    fprintf(stdout, "%ld\n",sysconf(_SC_CLK_TCK));

    return 0;
}
