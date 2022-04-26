-module(readfile).
-export([start/0, readfile/2]).
-include("record.hrl").

start() ->
    {ok, IOdevice} = file:open("data.txt", [read]),
    readfile(IOdevice, 10).

readfile(IOdevice, 0) ->
    file:close(IOdevice),
    finished;


readfile(IOdevice, N) ->
    {ok, Data}=file:read_line(IOdevice),
    [Token1,Token2,Token3withNewLine] = string:tokens(Data, ","),
    [Token3] = string:tokens(Token3withNewLine, "\n"),
    Record=#data{msisdn=Token1, services=Token2, bonus=Token3},
    io:format("msisdn equal ~p, ", [Record#data.msisdn]),
    io:format("The data equal ~p, ", [Record#data.services]),
    io:format("The bonus eqaual ~p~n", [Record#data.bonus]),
    readfile(IOdevice, N-1).
    