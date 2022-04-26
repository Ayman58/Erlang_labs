-module(math_stuff).
-export([perimeter/1]).

perimeter({square,Side}) ->
    io:format("square perimeter ~p",[Side*4]);
perimeter({circle,Radius}) ->
    io:format("circule perimeter ~p",[3.14*math:sqrt(Radius)]);
perimeter({triangle,A,B,C}) ->
    io:format("triangle perimeter ~p",[A+B+C]).