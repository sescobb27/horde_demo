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

```sh
iex --name demo1@127.0.0.1 --cookie hola -S mix
iex --name demo2@127.0.0.1 --cookie hola -S mix
iex --name demo3@127.0.0.1 --cookie hola -S mix
```

```sh
ERL_AFLAGS="-name demo1@127.0.0.1 -setcookie hola" iex -S mix
ERL_AFLAGS="-name demo2@127.0.0.1 -setcookie hola" iex -S mix
ERL_AFLAGS="-name demo3@127.0.0.1 -setcookie hola" iex -S mix
```

```ex
Horde.Supervisor.start_child(HordesDemo.DistributedSupervisor, HordesDemo.Worker)
HordesDemo.Worker.say_hello(HordesDemo.Worker)
Node.connect(:'demo1@demo1.local')
Node.connect(:'demo2@demo2.local')
Node.connect(:'demo3@demo3.local')
Horde.Registry.lookup(HordesDemo.DistributedRegistry, HordesDemo.Worker)
```

## Demo Video

[Horde Demo](https://www.youtube.com/watch?v=NPV_bAObK6U)

### Network Partitions

```
# /etc/hosts
127.0.0.1       demo1.local
127.0.0.1       demo2.local
127.0.0.1       demo3.local
```

```sh
iex --name demo1@demo1.local --cookie hola -S mix
iex --name demo2@demo2.local --cookie hola -S mix
iex --name demo3@demo3.local --cookie hola -S mix
```

```ex
[:'demo3@demo3.local', :'demo2@demo2.local'] |> Enum.map(&Node.disconnect/1)
[:'demo3@demo3.local', :'demo2@demo1.local'] |> Enum.map(&Node.disconnect/1)
[:'demo3@demo3.local', :'demo2@demo2.local'] |> Enum.map(&Node.connect/1)
```
