-module(temp).
-export([f2c/1, c2f/1]).


f2c(F) ->
    io:format("C ~p",[(5/9*(F-32))]).
c2f(C) ->
    io:format("F ~p",[(9/5*(C+160))]).