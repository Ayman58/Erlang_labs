-module(exercise1).
-export([grade/1]).

grade(10) ->
    io:format("you got full mark~n");
grade(9) ->
    io:format("you got very good ~n");
grade(N) ->
    io:format("you got ~p~n ", [N]).