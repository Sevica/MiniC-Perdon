package minic;
import java_cup.runtime.*;
%%

%unicode
%class lexer
%cupsym sym
%cup
%int
%line
%column
%ignorecase
%standalone
//
%{
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
       
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }

%} 

letra=[a-zA-Z]
digito=[0-9]
numero=({digito})+
palabra=({letra})+
identifier={letra}({letra}|{digito})*
espacio = [ \t]+
nuevalinea = \n | \n\r | \r\n
%%


"/*"[^[*/]]+"*/"  {} //Este es para los comentarios /*Cosas aqui*/ El Lexico Elimina los comentarios
"//"[^\n]+                 {} //Este es para los comentarios por linea //Cosas aqui
"\""[^"\""]+ "\""          {return symbol(sym.STRING, yytext());}
";"          {return symbol(sym.END, yytext());}
"*"      {return symbol(sym.POINTER, yytext());}
"+"         {return symbol(sym.PLUS, yytext());}
"-"        {return symbol(sym.MINUS, yytext());}
"/"     {return symbol(sym.DIVISION, yytext());}
"("     {return symbol(sym.ARG_INIT, yytext());}
")"      {return symbol(sym.ARG_END, yytext());} 
"%d"     {return symbol(sym.FORMAT_D, yytext());}
"%c"     {return symbol(sym.FORMAT_C, yytext());}
"++"    {return symbol(sym.INCREMENT, yytext());}
"--"    {return symbol(sym.DECREMENT, yytext());}
"?"  {return symbol(sym.CONDITIONAL, yytext());}
"[" {return symbol(sym.SIZEstr_INIT, yytext());}
"]"  {return symbol(sym.SIZEstr_END, yytext());}
"'"  {return symbol(sym.CHAR_LIMITS, yytext());}
"{"   {return symbol(sym.BLOCK_INIT, yytext());}
"}"    {return symbol(sym.BLOCK_END, yytext());}
"!"          {return symbol(sym.NOT, yytext());}
"!="     {return symbol(sym.DISTINCT, yytext());}
"="        {return symbol(sym.EQUAL, yytext());}
"=="   {return symbol(sym.BOOL_EQUAL, yytext());}
">"       {return symbol(sym.HIGHER, yytext());}
"<"       {return symbol(sym.LESSER, yytext());}
","         {return symbol(sym.COMA, yytext());}
">="    {return symbol(sym.HIGHER_EQUAL, yytext());}
"<=" {return symbol(sym.LESSER_EQUAL, yytext());}
"&&"          {return symbol(sym.AND, yytext());}
"||"           {return symbol(sym.OR, yytext());}
{numero}        {return symbol(sym.NUMERO,new String(yytext()));}
{identifier}({identifier}|{digito})*	{return symbol(sym.ID,new String(yytext()));}

"break"|"Break"|"BREAK"       {return symbol(sym.BREAK, yytext());}
"void"|"Void"|"VOID"         {return symbol(sym.VOID, yytext());}
"main"|"Main"|"MAIN"         {return symbol(sym.MAIN,yytext());}
//"char"|"Char"|"CHAR"         {return symbol(sym.CHAR, yytext());}
"int"|"Int"|"INT"          {return symbol(sym.INT, yytext());}
"scanf"|"Scanf"|"SCANF"        {return symbol(sym.SCANF, yytext());}
"printf"|"Printf"|"PRINTF"       {return symbol(sym.PRINTF, yytext());}
"const"|"Const"|"CONST"        {return symbol(sym.CONST, yytext());}
"while"|"While"|"WHILE"        {return symbol(sym.WHILE, yytext());}
"for"|"For"|"FOR"          {return symbol(sym.FOR, yytext());}
"if"|"If"|"IF"           {return symbol(sym.IF, yytext());}
"else"|"Else"|"ELSE"         {return symbol(sym.ELSE, yytext());}
"return"|"Return"|"RETURN"       {return symbol(sym.RETURN, yytext());}
{espacio}      {} //El Lexico elimina los espacios 
{nuevalinea}   {} //El Lexico elimina las lineas 
.               {System.err.println("Error encontrado en analisis lexico , con el caracter : " + yytext() +" en la linea "+ (yyline + 1) +" y columna " + (yycolumn+1)+ "\n");}
  