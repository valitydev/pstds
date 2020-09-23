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

-module(pstds_token_thrift_handler).

-behaviour(woody_server_thrift_handler).

-include_lib("pstds_proto/include/pstds_proto_storage_thrift.hrl").

%% woody_server_thrift_handler callbacks
-export([handle_function/4]).

%%
%% woody_server_thrift_handler callbacks
%%

-spec handle_function(woody:func(), woody:args(), woody_context:ctx(), woody:options()) ->
    {ok, woody:result()} | no_return().
handle_function(OperationID, Args, Context, Opts) ->
    scoper:scope(
        token_data,
        fun() -> handle_function_(OperationID, Args, Context, Opts) end
    ).

handle_function_('GetPaymentSystemTokenData', [TokenId], _Context, _Opts) ->
    try
        TokenContent = pstds_token_storage:get_token_data(TokenId),
        {ok, TokenContent}
    catch
        not_found ->
            raise(#pstds_storage_PaymentSystemTokenNotFound{})
    end;
handle_function_('PutPaymentSystemToken', [TokenData], _Context, _Opts) ->
    ok = pstds_token_storage:put_token_data(TokenData),
    {ok, ok};
handle_function_('UpdatePaymentSystemTokenStatus', [TokenID, Status], _Context, _Opts) ->
    try
        Revision = pstds_token_storage:update_token_status(TokenID, Status),
        {ok, Revision}
    catch
        not_found ->
            raise(#pstds_storage_PaymentSystemTokenNotFound{})
    end;
handle_function_('GetTokenRevision', [TokenID], _Context, _Opts) ->
    try
        Revision = pstds_token_storage:get_token_revision(TokenID),
        {ok, Revision}
    catch
        not_found ->
            raise(#pstds_storage_PaymentSystemTokenNotFound{})
    end.

-spec raise(_) -> no_return().
raise(Exception) ->
    woody_error:raise(business, Exception).
