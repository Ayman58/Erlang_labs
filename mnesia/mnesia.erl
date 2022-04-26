-module(mnesia).
-export([insert/0, list/0, lookup/1, delete/1, update/0]).

-record(subscriber, {sub_id, name}).



insert() ->
    Subscriber1 = #subscriber{sub_id=1,name=ahmed},
    subscriber_mnesia:store_subscriber(Subscriber1),
    Subscriber2 = #subscriber{sub_id=2, name=atef},
    subscriber_mnesia:store_subscriber(Subscriber2).

update() ->
    SubscriberEdit = #subscriber{sub_id=1, name=edited_name},
    subscriber_mnesia:update_subscriber(SubscriberEdit),

    SubscriberEditWrong = #subscriber{sub_id=17, name=wrong_edit},
    subscriber_mnesia:update_subscriber(SubscriberEditWrong).

delete(SubscriberID) ->
    subscriber_mnesia:delete_subscriber(SubscriberID).

list() ->
    subscriber_mnesia:list_all().

lookup(SubscriberID) ->
    Subscriber = subscriber_mnesia:lookup_subscriber(SubscriberID),
    io:format("Subscriber with id ~p is ~p~n", [SubscriberID, Subscriber]).





