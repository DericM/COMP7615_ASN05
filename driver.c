/*Deric Mccadden, A00751277
  2018-09-30*/
#include <stdio.h>

extern int mult_asm(int, int);

int main(){
    int c;
    c = mult_asm(3000000, -4000000);
    printf("Result is %d \n", c);
}
