/**
 * Traducción dirigida por la Sintaxis que genera C3D
 */

/* Definición Léxica */
%lex

%options case-insensitive

%%

"("					return 'PARIZQ';
")"					return 'PARDER';

"+"					return 'MAS';
"-"					return 'MENOS';
"*"					return 'POR';
"/"					return 'DIVIDIDO';


/* Espacios en blanco */
[ \r\t]+			{}
\n					{}


[0-9]+\b				return 'ENTERO';
([a-zA-Z])[a-zA-Z0-9_]*	return 'IDENTIFICADOR';

<<EOF>>				return 'EOF';

.					{ console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex

%{
	const instruccionesAPI	= require('./instrucciones').instruccionesAPI;
	let n = 0; //variable para el control de temporales
%}


%start ini

%% /* Definición de la gramática */

ini
	: E EOF					{ $$ = $1; console.log($$.codigo);}
;

E
	: E MAS T
	{
		n++; 
		$$ = instruccionesAPI.nuevoTemp("T"+n); 
		$$.codigo = $$.temporal + " = " + $1.temporal + " + "  + $3.temporal + "\n";
		$$.codigo = $1.codigo + $3.codigo + $$.codigo;
	}
	| E MENOS T
	{
		n++; 
		$$ = instruccionesAPI.nuevoTemp("T"+n); 
		$$.codigo = $$.temporal + " = " + $1.temporal + " - "  + $3.temporal + "\n";
		$$.codigo = $1.codigo + $3.codigo + $$.codigo;
	}
	| T						{ $$ = $1; }
;

T
	: T POR F
	{
		n++; 
		$$ = instruccionesAPI.nuevoTemp("T"+n); 
		$$.codigo = $$.temporal + " = " + $1.temporal + " * "  + $3.temporal + "\n";
		$$.codigo = $1.codigo + $3.codigo + $$.codigo;
	}
	| T DIVIDIDO F			
	{ 
		n++; 
		$$ = instruccionesAPI.nuevoTemp("T"+n); 
		$$.codigo = $$.temporal + " = " + $1.temporal + " / "  + $3.temporal + "\n";
		$$.codigo = $1.codigo + $3.codigo + $$.codigo;
	}
	| F						{ $$ = $1; }
;

F
	: ENTERO				{ $$ = instruccionesAPI.nuevoTemporal(); $$.codigo = ""; $$.temporal = $1; }
	| PARIZQ E PARDER		{ $$ = $2; }
	| IDENTIFICADOR 		{ $$ = instruccionesAPI.nuevoTemporal(); $$.codigo = ""; $$.temporal = $1; }
;