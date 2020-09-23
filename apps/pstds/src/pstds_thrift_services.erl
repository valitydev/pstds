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

-module(pstds_thrift_services).

%% API
-export([handler_spec/1]).
-export([service_path/1]).
-export([thrift_service/1]).

%%
%% Types
%%

-type storage_code() :: token_data.

-export_type([storage_code/0]).

%% Internal types

-type path() :: woody:path().
-type thrift_service() :: woody:service().
-type hadler_spec() :: woody:handler(list()).

-type service_hadler_spec() :: {path(), {thrift_service(), hadler_spec()}}.

%%
%% API
%%

-spec handler_spec(storage_code()) -> service_hadler_spec().
handler_spec(Code) ->
    {service_path(Code), {thrift_service(Code), handler_module(Code)}}.

-spec service_path(storage_code()) -> path().
service_path(token_data) ->
    "/v1/token_storage".

-spec thrift_service(storage_code()) -> thrift_service().
thrift_service(token_data) ->
    {tds_proto_storage_thrift, 'TokenStorage'}.

-spec handler_module(storage_code()) -> hadler_spec().
handler_module(token_data) ->
    {pstds_token_thrift_handler, []}.
