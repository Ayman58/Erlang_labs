-module(parser).
-export([start/0]).
-import(lists,[nth/2]).
-include("record.hrl").
start() ->
    {ok, IODevice} = file:open("data.csv", [read]),
    openFile(IODevice).

openFile(IODevice) ->
    case io:get_line(IODevice,"/n") of
        eof  ->
            file:close(IODevice);
        Line ->
            [A, B, C] = string:tokens(Line, ","),
            P = #subscriber_data{msisdn=A,service_class = B,bonus=nth(1,string:tokens(C,"\n"))},
            io:format(" the custiomer msisdn: ~p and servise class id : ~p his/her bounse: ~p~n ",
                [P#subscriber_data.msisdn,P#subscriber_data.service_class,P#subscriber_data.bonus]),
            openFile(IODevice)
            
    end.

