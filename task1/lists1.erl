-module(lists1).
-export([nth/2, sublist/2]).

nth(1,[H|_]) ->
    H;

nth(N,[_|T]) ->
    nth(N-1, T).


sublist([H|_],1) -> 
    [H];
sublist([H|T],N) ->
    [H|sublist(T,N-1)].

