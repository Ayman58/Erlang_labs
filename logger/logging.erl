-module(logging).
-import(lists,[nth/2]).
-export([start_logger/0,to_logger/1]).

start_logger()->
    {ok, Device} = file:open("config.csv", [read]),
    spawn(logging,logger,[Device,1]).
    

logger(Device,Serial) ->
    register(my_logger,self()),
    case io:get_line(Device,"/n") of
        eof  ->
            file:close(Device);
        Line ->
            [A, B, C] = string:tokens(Line, ","),
            P = #config_data{directory=A,prefix = B,size=nth(1,string:tokens(C,"\n"))},

            {ok, Dev} = file:open("log.log",[write]),
            rec(Dev,Serial)
    end.

rec(Device,Serial)->
    io:format("iam in "),
    receive
        {admin,reload_config} ->
            logger(Device,1);
        {admin,stop} ->
            terminated;
        Msg ->
            io:format("~p ~n", [Msg]),       
            io:format(Device, "~s~n", [Msg]),
            rec(Device,Serial)
        end.


to_logger({Str,Pid})->
    my_logger ! {Str,Pid},
    {Str,Pid}.