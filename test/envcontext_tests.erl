
-module(envcontext_tests).
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").
-include("envcontext_context.hrl").

call_with_set_test() ->
    TestingVar = "ENVCONTEXT_TESTING",
    Context = #context{vars=[
        {TestingVar, "true"}
    ]},
    false = os:getenv(TestingVar),
    envcontext:call_with(fun() -> "true" = os:getenv(TestingVar) end, Context),
    false = os:getenv(TestingVar).

call_with_unset_variable_test() ->
    TestingVar = "ENVCONTEXT_TESTING",
    Context = #context{vars=[
        {TestingVar, unset}
    ]},
    os:putenv(TestingVar, "true"),

    "true" = os:getenv(TestingVar),
    envcontext:call_with(fun() -> false = os:getenv(TestingVar) end, Context),
    "true" = os:getenv(TestingVar).

-endif.
