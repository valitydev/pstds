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

-module(pstds).

-type token() :: <<_:128>>.
-type token_data() :: pstds_token_data:token_data().

-export_type([token/0]).

%% API
-export([token/0]).

%% Storage operations
-export([put_token_data/1]).

-spec token() -> token().
token() ->
    crypto:strong_rand_bytes(16).

-spec put_token_data(token_data()) -> {ok, token()}.
put_token_data(_TokenData) ->
    error(not_implemented).
