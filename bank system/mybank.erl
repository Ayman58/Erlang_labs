-module(mybank).
-behaviour(gen_server).

%% API
-export([start_link/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
terminate/2, code_change/3]).

-define(SERVER, ?MODULE). 

start_link(BName) ->
    gen_server:start_link({local,?SERVER}, ?MODULE, [BName], []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init(Bank) ->
    io:format("Bank ~p is on ~n",[Bank]),
    {ok,[]}. %to store accounts

handle_call(veiwAcounts, _From, State) ->
    {reply,State, State};

handle_call({veiwAcount,Name}, _From, State) ->
        Reply ={Name,proplists:lookup(Name,State)},
        {reply, Reply,State};

handle_call({withdraw,Name,Value},_From, State) ->

    V=proplists:get_value(Name,State),
    if 
        V==0 ->
            {reply,yourbalanceisZer00,State};
        true->  
            {reply,proplists:get_value(Name,State)-Value,[{Name,proplists:get_value(Name,State)-Value}|proplists:delete(Name,State)]}
    end.        

handle_cast({deposit,Name,Value}, State) ->
    {noreply,[{Name,proplists:get_value(Name,State)+Value}|proplists:delete(Name,State)]};
                        
handle_cast({newAcount,Name}, State) ->
    {noreply,[{Name,0} |State]}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    bankIsOff.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================