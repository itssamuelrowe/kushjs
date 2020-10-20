const antlr4 = require('antlr4');
const { KushLexer } = require('../generated/KushLexer');
const { KushParser } = require('../generated/KushParser');
const { KushListener } = require('../generated/KushListener');
const fs = require("fs");

const input = fs.readFileSync("test.kush");
const chars = new antlr4.InputStream(input.toString());
const lexer = new KushLexer(chars);
const tokens  = new antlr4.CommonTokenStream(lexer);
const parser = new KushParser(tokens);
parser.buildParseTrees = true;
const tree = parser.compilationUnit();