grammar Kush;

compilationUnit
:   importDeclaration*
    componentDeclarations*
    EOF
;

componentDeclarations
:   functionDeclaration
|   structureDeclaration
;

importDeclaration
:   'import' qualifiedName ';'
;

qualifiedName
:   IDENTIFIER ('.' IDENTIFIER)*
;

functionDeclaration
:   returnType IDENTIFIER functionParameters functionBody
;

functionParameters
:   '(' functionParameterList? ')'
;

functionParameterList
:   functionParameter (',' functionParameter)* (',' variableFunctionParameter)?
|   variableFunctionParameter
;

functionParameter
:   type IDENTIFIER
;

variableFunctionParameter
:   type '...' IDENTIFIER
;

functionBody
:   blockStatement
;

blockStatement
:   '{' statement* '}'
;

statement
:   simpleStatement
|   compoundStatement
;

simpleStatement
:   unterminatedSimpleStatement ';'
;

unterminatedSimpleStatement
:   expressionStatement
|   emptyStatement
|   storageDeclaration
|   breakStatement
|   returnStatement
|   throwStatement
;

expressionStatement
:   expression
;

emptyStatement
:   ';'
;

storageDeclaration
:   ('var' | 'let' | type) storageDeclarator (',' storageDeclarator)*
;

storageDeclarator
:   IDENTIFIER ('=' expression)?
;

breakStatement
:   'break' IDENTIFIER?
;

returnStatement
:   'return' expression
;

throwStatement
:   'throw' expression
;

compoundStatement
:   ifStatement
|   iterativeStatement
;

ifStatement
:   ifClause elseIfClause* elseClause?
;

ifClause
:   'if' expression blockStatement
;

elseIfClause
:   'else' 'if' expression blockStatement
;

elseClause
:   'else' blockStatement
;

iterativeStatement
:   labelClause? (whileStatement | forStatement)
;

labelClause
:   '#' IDENTIFIER
;

whileStatement
:   'while' expression blockStatement
;

forStatement
:   'for' 'var' IDENTIFIER ':' expression blockStatement
;

structureDeclaration
:   'struct' IDENTIFIER structureBody
;

structureBody
:   '{' structureMembers? '}'
;

structureMembers
:   structureMember+
;

structureMember
:   type IDENTIFIER ';'
;

type
:   componentType ('[' ']')*
;

componentType
:   IDENTIFIER
|   'boolean'
|   'i8'
|   'i16'
|   'i32'
|   'i64'
|   'f32'
|   'f64'
;

returnType
:   'void'
|   type
;

expressions
:    expression (',' expression)*
;

expression
:	assignmentExpression
;

assignmentExpression
:	conditionalExpression ('=' assignmentExpression)?
;

conditionalExpression
:	condition ('?' expression ':' conditionalExpression)?
;

condition
:	logicalAndExpression ('||' logicalAndExpression)*
;

logicalAndExpression
:	inclusiveOrExpression ('&&' logicalAndExpression)?
;

inclusiveOrExpression
:	exclusiveOrExpression ('|' exclusiveOrExpression)*
;

exclusiveOrExpression
:	andExpression ('^' andExpression)*
;

andExpression
:	equalityExpression ('&' equalityExpression)*
;

equalityExpression
:	relationalExpression (equalityOperator relationalExpression)*
;

equalityOperator
:	'=='
|	'!='
;

relationalExpression
:	shiftExpression (relationalOperator shiftExpression)*
;

relationalOperator
:	'<'
|	'>'
|	'<='
|	'>='
;

shiftExpression
:	additiveExpression (shiftOperator additiveExpression)*
;

shiftOperator
:	'<<'
|	'>>'
;

additiveExpression
:	multiplicativeExpression (multiplicativeOperator multiplicativeExpression)*
;

additiveOperator
:	'+'
|	'-'
;

multiplicativeExpression
:	unaryExpression (multiplicativeOperator unaryExpression)*
;

multiplicativeOperator
:	'*'
|	'/'
|	'%'
;

unaryExpression
:	unaryOperator unaryExpression
|	postfixExpression
;

unaryOperator
:    '+'
|    '-'
|    '~'
|    '!'
;

postfixExpression
:	primaryExpression postfixPart*
;

postfixPart
:    subscript
|    functionArguments
|    memberAccess
;

subscript
:	'[' expression ']'
;

functionArguments
:	'(' expressions? ')'
;

memberAccess
:	'.' IDENTIFIER
;

primaryExpression
:	IDENTIFIER
|	literal
|	'(' expression ')'
|	listExpression
|   constructorExpression
|   closureExpression
|   newExpression
;

constructorExpression
:   '{' memberAssignments? '}'
;

memberAssignments
:   memberAssignment (',' memberAssignment)*
;

memberAssignment
:   IDENTIFIER ':' expression
;

literal
:	INTEGER_LITERAL
|	FLOATING_POINT_LITERAL
|	'true'
|	'false'
|	STRING_LITERAL
|	'null'
|   'this'
;

listExpression
:    '[' expressions ']'
;

newExpression
:    'new' IDENTIFIER functionArguments
;

closureExpression
:   '@' closureParameters? closureBody
;

closureParameters
:   '(' IDENTIFIER (',' IDENTIFIER)+ ')'
|   IDENTIFIER
;

closureBody
:   '->' expression
|   blockStatement
;

/*
The various forms of a closure are given below.
```
@ -> expression
@argument -> expression
@(argument1, argument2) -> expression
@{
    statement1
    ...
    statementN
}
@argument {
    statement1
    ...
    statementN
}

@(argument1, argument2) {
    statement1
    ...
    statementN
}
```
*/

WS  :  [ \t\r\n\u000C]+ -> skip
    ;

COMMENT
    :   '/*' .*? '*/' -> skip
    ;

LINE_COMMENT
    :   '//' ~[\r\n]* -> skip
    ;

IDENTIFIER
    :   [a-zA-Z_][a-zA-Z_0-9]+
    ;

STRING_LITERAL
    :   '\'' StringCharacter+? '\''
    ;

fragment StringCharacter
    :   ~["\\]
    |   EscapeSequence
    ;

fragment EscapeSequence
    :   '\\' [btnfr"'\\]
    ;





INTEGER_LITERAL
    :   DecimalIntegerLiteral
    |   HexIntegerLiteral
    |   OctalIntegerLiteral
    |   BinaryIntegerLiteral
    ;

fragment
DecimalIntegerLiteral
    :   DecimalNumeral IntegerTypeSuffix?
    ;

fragment
HexIntegerLiteral
    :   HexNumeral IntegerTypeSuffix?
    ;

fragment
OctalIntegerLiteral
    :   OctalNumeral IntegerTypeSuffix?
    ;

fragment
BinaryIntegerLiteral
    :   BinaryNumeral IntegerTypeSuffix?
    ;

fragment
IntegerTypeSuffix
    :   [lL]
    ;

fragment
DecimalNumeral
    :   '0'
    |   NonZeroDigit (Digits? | Underscores Digits)
    ;

fragment
Digits
    :   Digit (DigitsAndUnderscores? Digit)?
    ;

fragment
Digit
    :   '0'
    |   NonZeroDigit
    ;

fragment
NonZeroDigit
    :   [1-9]
    ;

fragment
DigitsAndUnderscores
    :   DigitOrUnderscore+
    ;

fragment
DigitOrUnderscore
    :   Digit
    |   '_'
    ;

fragment
Underscores
    :   '_'+
    ;

fragment
HexNumeral
    :   '0' [xX] HexDigits
    ;

fragment
HexDigits
    :   HexDigit (HexDigitsAndUnderscores? HexDigit)?
    ;

fragment
HexDigit
    :   [0-9a-fA-F]
    ;

fragment
HexDigitsAndUnderscores
    :   HexDigitOrUnderscore+
    ;

fragment
HexDigitOrUnderscore
    :   HexDigit
    |   '_'
    ;

fragment
OctalNumeral
    :   '0' Underscores? OctalDigits
    ;

fragment
OctalDigits
    :   OctalDigit (OctalDigitsAndUnderscores? OctalDigit)?
    ;

fragment
OctalDigit
    :   [0-7]
    ;

fragment
OctalDigitsAndUnderscores
    :   OctalDigitOrUnderscore+
    ;

fragment
OctalDigitOrUnderscore
    :   OctalDigit
    |   '_'
    ;

fragment
BinaryNumeral
    :   '0' [bB] BinaryDigits
    ;

fragment
BinaryDigits
    :   BinaryDigit (BinaryDigitsAndUnderscores? BinaryDigit)?
    ;

fragment
BinaryDigit
    :   [01]
    ;

fragment
BinaryDigitsAndUnderscores
    :   BinaryDigitOrUnderscore+
    ;

fragment
BinaryDigitOrUnderscore
    :   BinaryDigit
    |   '_'
    ;

// §3.10.2 Floating-Point Literals

FLOATING_POINT_LITERAL
    :   DecimalFloatingPointLiteral
    |   HexadecimalFloatingPointLiteral
    ;

fragment
DecimalFloatingPointLiteral
    :   Digits '.' Digits? ExponentPart? FloatTypeSuffix?
    |   '.' Digits ExponentPart? FloatTypeSuffix?
    |   Digits ExponentPart FloatTypeSuffix?
    |   Digits FloatTypeSuffix
    ;

fragment
ExponentPart
    :   ExponentIndicator SignedInteger
    ;

fragment
ExponentIndicator
    :   [eE]
    ;

fragment
SignedInteger
    :   Sign? Digits
    ;

fragment
Sign
    :   [+\-]
    ;

fragment
FloatTypeSuffix
    :   [fFdD]
    ;

fragment
HexadecimalFloatingPointLiteral
    :   HexSignificand BinaryExponent FloatTypeSuffix?
    ;

fragment
HexSignificand
    :   HexNumeral '.'?
    |   '0' [xX] HexDigits? '.' HexDigits
    ;

fragment
BinaryExponent
    :   BinaryExponentIndicator SignedInteger
    ;

fragment
BinaryExponentIndicator
    :   [pP]
    ;