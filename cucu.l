%{
  #include <stdio.h>
  #include "y.tab.h"
  FILE *lexer;
%}

%%
"/*"[^("*/")]*"*/"          ;
"int"			                {fprintf(lexer,"TYPE: int\n");return TYPE;}
"char *"			            {fprintf(lexer,"TYPE: char *\n");return TYPE;}	
"return"                  {fprintf(lexer,"KEYWORD: return\n");return RETURN;}
"while"                   {fprintf (lexer,"KEYWORD: while\n"); return WHILE;}
"if"                      {fprintf (lexer,"KEYWORD: if\n"); return IF;}
"else"                    {fprintf (lexer,"KEYWORD: else\n"); return ELSE;}
\s+		
"("                        {fprintf(lexer,"OBRACE: (\n");return OBRACE;}
")"                        {fprintf(lexer,"EBRACE: )\n");return EBRACE;}
"{"                       {fprintf(lexer,"OBRACE: {\n");return OCBRACE;}
"}"                       {fprintf(lexer,"EBRACE: }\n");return ECBRACE;}
[0-9]+				            {fprintf(lexer,"NUM: %s\n",yytext);yylval.str=strdup(yytext);return INTEGER;}
"+"		                    {fprintf(lexer,"PLUS: +\n");return PLUS;}
"-"		                    {fprintf(lexer,"MINUS: -\n");return MINUS;}
"/"	                      {fprintf(lexer,"DIV: \\n");return DIV;}
"*"		                    {fprintf(lexer,"MUL: *\n");return MUL;}
";"                       {fprintf(lexer,"SEMI: ;\n");return SEMI;}
"="                       {fprintf(lexer,"ASSIGN: =\n");return ASSIGN;}
","                        {fprintf(lexer,"COMMA: ,\n");return COMMA;}
">"                     {fprintf (lexer,"RELATIONAL_OP: >\n"); return GT;}
"<"                     {fprintf (lexer,"RELATIONAL_OP: <\n"); return LT;}
"=="                    {fprintf (lexer,"RELATIONAL_OP: ==\n"); return EQ;}
"<="                    {fprintf (lexer,"RELATIONAL_OP: <=\n"); return LEQ;}
">="                    {fprintf (lexer,"RELATIONAL_OP: >=\n"); return GEQ;}
"!="                    {fprintf (lexer,"RELATIONAL_OP: !=\n"); return NEQ;}
[a-zA-Z_][a-zA-Z_0-9]*		{fprintf(lexer,"IDENTIFIER: %s\n", yytext);yylval.str=strdup(yytext);return IDENTIFIER;}



%%

