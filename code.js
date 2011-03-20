// 3rd party libraries.
<!--#include virtual="3rd/jquery-1.4.2.js" -->

// CoffeeScript utilities.
var __slice = Array.prototype.slice
var __bind = function (fn, me) { return function bind () { return fn.apply(me, arguments); }; };

// Generated JavaScript.
<!--#exec cmd="js-shell code/gen/Compiler.js `find code/gen -name '*.js' \! -name 'Compiler.js'` -e 'js.compile();'" -->

// Startup application.
__ui_Main()
