-module(envcontext).

-include("envcontext_context.hrl").

%% API exports
-export([call_with/2]).

%% Set a single environment variable value and return it's previous state.
%% When the Value is unset, the variable will be removed from the environment,
%% unset will be returned when the value was not previously set.
set_var({Key, unset}) ->
    os:unsetenv(Key),
    {Key, unset};

set_var({Key, Value}) ->
    Prev = {Key, os:getenv(Key)},
    os:putenv(Key, Value),
    case Prev of
        {Key, false} -> {Key, unset};
        _ -> Prev
    end.

set_vars(Vars) ->
    lists:map(fun set_var/1, Vars).

%% @doc Call a function under a context. All things changed by the context will
%%      be reset after returning from the function.
call_with(F, #context{vars=Vars}) ->
    Old = set_vars(Vars),
    Ret = F(),
    set_vars(Old),
    Ret.
