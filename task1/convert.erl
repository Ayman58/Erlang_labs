-module(convert).
-export([convert/1]).


convert({f,X}) ->
    io:format("C ~p",[(5*(X-32))/9]);
convert({c,X}) ->
    io:format("F ~p",[((9*X+160)/5)]).