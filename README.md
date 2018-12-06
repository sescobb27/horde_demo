# HordesDemo

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `hordes_demo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:hordes_demo, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/hordes_demo](https://hexdocs.pm/hordes_demo).

iex --name demo1@121.0.0.1 --cookie hola -S mix
iex --name demo2@121.0.0.1 --cookie hola -S mix
iex --name demo3@121.0.0.1 --cookie hola -S mix

ERL_AFLAGS="-name demo1@127.0.0.1 -setcookie hola" iex -S mix
ERL_AFLAGS="-name demo2@127.0.0.1 -setcookie hola" iex -S mix
ERL_AFLAGS="-name demo3@127.0.0.1 -setcookie hola" iex -S mix

Horde.Supervisor.start_child(HordesDemo.DistributedSupervisor, HordesDemo.Worker)
HordesDemo.Worker.say_hello(HordesDemo.Worker)
Node.connect(:'demo1@127.0.0.1')
Node.connect(:'demo2@127.0.0.1')
Node.connect(:'demo3@127.0.0.1')

Horde.Registry.lookup(HordesDemo.DistributedRegistry, HordesDemo.Worker)
