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

-module(pstds_token_data).

%% Public API
-export([validate/1]).

-export([marshal_token_data/1]).
-export([unmarshal_token_data/1]).

-type exp_date() :: {1..12, pos_integer()}.

-type token_data() :: #{
    exp_date := exp_date()
}.

-type marshalled() :: binary().

-type reason() ::
    unrecognized |
    {invalid, exp_date}.

-spec validate(token_data()) -> {ok, token_data()} | {error, reason()}.
validate(_TokenData) ->
    error(not_implemented).

-spec marshal_token_data(token_data()) -> marshalled().
marshal_token_data(_TokenData) ->
    error(not_implemented).

-spec unmarshal_token_data(marshalled()) -> token_data().
unmarshal_token_data(_Marshalled) ->
    error(notimplemented).
