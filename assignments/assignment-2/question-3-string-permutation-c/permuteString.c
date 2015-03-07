/* permuteString.c
 * Simple, inefficient method to generate all permutations of an input string.
 *
 * @author: Yinwei (Charlie) Zhang
 * @for: TAMU ECEN449 Microprocessors, Spring 2015.
 */

#include <stdio.h>
#include <string.h>

///////////////////////
// Utility Functions //
///////////////////////

//swap 2 characters via their pointers
void swap(char* a, char* b) {
  char temp = *a;
  *a = *b;
  *b = temp;
  return;
}

///////////////////////
// Main Function     //
///////////////////////
/* Our "main" function.  It recursively goes through a permutation on the string and prints them out.
 * Theory
 * ======
 * We do our input string, lets say "abcd".  Our approach takes all the permutations of our original string, 
 * then adds it to permutations of each of the substrings.  That to say:
 *
 * "a" + permuation("bcd") + "b" + permutation("acd") + c + permutation("abd") + d + permutation("abc")
 *
 * Our approach is to create a recursive tree, generating the smallest 2 character recursions first, via swaps.
 *
 * IO
 * ==
 * It takes in a FILE* descriptor to print to the text file.
 * It then takes in our c string input, the ending and starting integer indexes.
 * It outputs to a file specified by pFile, which is initialized outside of our function.
 */
 
void permute(FILE* pFile, char* input, unsigned int endIndex, unsigned int startIndex) {
  if (startIndex == endIndex) {
    fprintf(pFile, "%s\n", input);
  }
  else {
    for (unsigned int i=startIndex; i<=endIndex; i++) {
      swap(input+startIndex, input+i); //pointer arithmetic
      permute(pFile, input, endIndex, startIndex+1); 
      swap(input+startIndex, input+i);
    }
  }
  return;
}

///////////////////////
// Driver Function   //
///////////////////////

//Note: need to remove q1out.txt before running this
int main() {
  //opening our output text
  char filename[] = "q1out.txt";
  FILE* pFile;
  pFile = fopen("q1out.txt", "w");
  if (pFile == NULL) {
    fprintf(stderr, "Error: can't open %s. Bye.\n", filename);
    return 1;
  }

  //waits for input
  printf("Please enter an input string. (Max length of 256).\n");
  char input[256];
  gets(input); //deprecated, but still useful

  permute(pFile, input, strlen(input)-1, 0);
  
  fclose(pFile); //closing loose ends
  return 0;
}
