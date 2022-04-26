-module(subscriber).
-export([start/0,store/1, update/1, delete/1, lookup/1, list_all/0]).


-record(subscriber, {sub_id, name}).
start() ->
    start_mnesia(),
    create_table().

start_mnesia() ->
    mnesia:create_schema([node()]),
    mnesia:start(),
    io:format("Mnesia Successfully started~n").

create_table() ->
   mnesia:create_table(subscriber, [{attributes, record_info(fields, subscriber)}]),
   io:format("Table subscriber successfully created~n"). 


store(Subscriber) ->
    SubscriberID = Subscriber#subscriber.sub_id,
    SubscriberFromDB = lookup(SubscriberID),
    check_and_store(Subscriber, SubscriberFromDB).
    

check_and_store(Subscriber, []) ->
    mnesia:dirty_write(Subscriber),
    io:format("Successfully inserted~n");

check_and_store(_, _) ->
    io:format("Already exists~n").

update(Subscriber) ->
    SubscriberID = Subscriber#subscriber.sub_id,
    SubscriberFromDB = lookup(SubscriberID),
    check_and_update(Subscriber, SubscriberFromDB).

check_and_update(_, []) ->
    io:format("Subscriber does not exist~n");

check_and_update(Subscriber, _) ->
    mnesia:dirty_write(subscriber, Subscriber),
    io:format("Successfully updated~n").

delete(SubscriberID) ->
    SubscriberFromDB = lookup(SubscriberID),
    check_and_delete(SubscriberFromDB).

check_and_delete([]) ->
    io:format("Subscriber does not exist~n");

check_and_delete([Subscriber]) ->
    mnesia:dirty_delete(subscriber, Subscriber#subscriber.sub_id),
    io:format("Successfully deleted~n").

lookup(SubscriberID) ->
    mnesia:dirty_read(subscriber, SubscriberID).

list_all() ->
    mnesia:dirty_select(subscriber, [{'_',[],['$_']}]).