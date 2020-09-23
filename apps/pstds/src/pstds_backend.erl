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

-module(pstds_backend).

%% API
-export([call/3]).

-spec call(atom(), atom(), list()) -> ok | term().
call(Key, Method, Args) ->
    {ok, Module} = application:get_env(pstds, Key),
    try erlang:apply(Module, Method, Args) of
        ok ->
            ok;
        {ok, Return} ->
            Return;
        {error, Error} ->
            throw(Error)
    catch
        Class:Reason:Stacktrace ->
            _ = logger:error(
                "~p (~p) ~p failed~nClass: ~s~nReason: ~p~nStacktrace: ~s",
                [
                    Key,
                    Module,
                    Method,
                    Class,
                    Reason,
                    genlib_format:format_stacktrace(Stacktrace)
                ]
            ),
            handle_error(Class, Reason)
    end.

-spec handle_error(atom(), _) -> no_return().
handle_error(throw, {pool_error, no_members}) ->
    woody_error:raise(system, {internal, resource_unavailable, <<"{pool_error,no_members}">>});
handle_error(error, timeout) ->
    woody_error:raise(system, {internal, result_unknown, <<"timeout">>});
handle_error(Class, Reason) ->
    exit({backend_error, {Class, Reason}}).
