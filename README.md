envcontext
=====

Run synchronous Erlang functions under a different environment context.
Here environment means environment variables. This only works with synchronous
functions.

Before calling your function your are in context A, when calling
a new function with this module you will be in context B. When your function
returns you will be in context A again.

We seek to also support asynchronous functions.

Usage
==========

```erlang

Context = #context{vars=[
    {"TESTING", "1"}
]}.

false = os:getenv("TESTING").

envcontext:call_with(fun() -> "1" = os:getenv("TESTING") end, Context).

false = os:getenv("TESTING").

```

Build
-----

    $ rebar3 compile
