%%%-------------------------------------------------------------------
%% @doc pstds public API
%% @end
%%%-------------------------------------------------------------------

-module(pstds_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    pstds_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
