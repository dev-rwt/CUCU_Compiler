# CUCU_Compiler
THE PROGRAM SHOULBE BE RUN WITH THE FOLLOWING COMMANDS:
'''bash
lex cucu.l
yacc -d cucu.y
cc lex.yy.c y.tab.c -o cucu
./cucu {Name of the file to be tested}
'''
(For example: ./cucu Sample1.cu)
  
cucu.l:
This file generates all the tokens by parsing throught the input file and gives the tokens as output in Lexer.txt

cucu.y:
This file contains the grammar of the language which was given and the sequential output is given in Parser.txt

Lexer.txt:
Contains the type of token along with the matched string

Parser.txt:
Contains when and where a statement was executed or function was called

Sample1.cu:
Contains a correct implementation of cucu language

Sample2.cu:
Contains an incorrect implementation of cucu language
Uncomment to view some other errors at the beginning itself
