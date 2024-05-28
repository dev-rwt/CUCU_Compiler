%{

#include <stdio.h>
#include <string.h>

void yyerror(const char *str){
	fprintf(stderr,"error: %s\n",str);
}

int yywrap(){
	return 1;
}

extern FILE *yyin,*yyout,*lexer;



%}

%union{
    int num;
    char *str;
}

%token RETURN WHILE IF ELSE TYPE COMMA PLUS MINUS DIV MUL ASSIGN INTEGER IDENTIFIER OCBRACE ECBRACE OBRACE EBRACE SEMI
%token EQ LT GT GEQ LEQ NEQ 
%left PLUS MINUS MUL DIV OBRACE EBRACE

%type <str> INTEGER IDENTIFIER

%%

PROGRAM: FDEC 
		| VDEC
		| FDEF
		| PROGRAM VDEC
		| PROGRAM FDEC
		| PROGRAM FDEF
		;

VDEC: TYPE ID SEMI				
	| TYPE ID ASSIGN E SEMI		{fprintf(yyout,"variable assigned\n");}
	;

FDEC: TYPE ID OBRACE FARG EBRACE SEMI	
	;

FARG: TYPE ID COMMA FARG					
	| TYPE ID							{fprintf(yyout,"Function arguements above");}
	;

FDEF: TYPE ID OBRACE FARG EBRACE OCBRACE STMTLIST ECBRACE
	| TYPE ID OBRACE EBRACE OCBRACE STMTLIST ECBRACE
	;

STMTLIST: STMTLIST STMT
		| STMT

STMT: VDEC	
	| FCALL SEMI{fprintf(yyout,"Function call ends\n");}
	| CONDSTMT {fprintf(yyout,"IF condition ends\n");}	
	| LOOPSTMT {fprintf(yyout,"Loop ends\n");}								
	| RSTMT {fprintf(yyout,"Function returns\n");}
	| ASTMT
	;

FCALL: ID OBRACE EBRACE SEMI
	| ID OBRACE ARGLIST EBRACE 
	;

ARGLIST: NUM COMMA ARGLIST
	   | ID COMMA ARGLIST
	   | NUM
	   | ID
	   ;

CONDSTMT: IF OBRACE REL EBRACE OCBRACE STMTLIST ECBRACE ELSE OCBRACE STMTLIST ECBRACE
		;

LOOPSTMT: WHILE OBRACE REL EBRACE OCBRACE STMTLIST ECBRACE
		;

REL: REL LT REL
	| REL GT REL
	| REL EQ REL
	| REL LEQ REL
	| REL GEQ REL
	| REL NEQ REL
	| E

RSTMT: RETURN SEMI
	| RETURN E SEMI

ASTMT: E ASSIGN E SEMI
	;

E: OBRACE E EBRACE
  |E PLUS E				{fprintf(yyout,"Operator : + \n");}
  |E MINUS E				{fprintf(yyout,"Operator : - \n");}
  |E MUL E				{fprintf(yyout,"Operator : * \n");}
  |E DIV E				{fprintf(yyout,"Operator : / \n");}
  |NUM
  |ID
 ;



NUM: INTEGER {fprintf(yyout,"const- %s ",$1);}
ID: IDENTIFIER {fprintf(yyout,"variable- %s ",$1);}


%%

int main(int argc, char *argv[]) {
	lexer = fopen("Lexer.txt","w");
	yyin = fopen(argv[1], "r");
	yyout = fopen("Parser.txt","w");
	yyparse();
	fclose(yyin);
	fclose(yyout);
	fclose(lexer);
}
