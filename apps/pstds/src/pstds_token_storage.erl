%%%
%%% Copyright 2020 RBKmoney
%%%
%%% Licensed under the Apache License, Version 2.0 (the "License");
%%% you may not use this file except in compliance with the License.
%%% You may obtain a copy of the License at
%%%
%%%     http://www.apache.org/licenses/LICENSE-2.0
%%%
%%% Unless required by applicable law or agreed to in writing, software
%%% distributed under the License is distributed on an "AS IS" BASIS,
%%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%% See the License for the specific language governing permissions and
%%% limitations under the License.
%%%

-module(pstds_token_storage).

%% API
-export([get_namespaces/0]).

%%-export([get_token_data/1]).
%%-export([put_token_data/1]).
%%-export([update_token_status/2]).
%%-export([get_token_revision/1]).

-define(TOKEN_NS, <<"payment_system_token_data">>).

-spec get_namespaces() -> [pstds_storage:namespace()].
get_namespaces() ->
    [?TOKEN_NS].

%%get_token_data(_TokenID) ->
%%    erlang:error(not_implemented).
%%
%%put_token_data(_TokenData) ->
%%    erlang:error(not_implemented).
%%
%%update_token_status(_TokenID, _Status) ->
%%    erlang:error(not_implemented).
%%
%%get_token_revision(_TokenID) ->
%%    erlang:error(not_implemented).
