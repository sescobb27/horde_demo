defmodule HordesDemo.Worker do
  use GenServer

  def start_link(args) do
    name = Keyword.get(args, :name, __MODULE__)
    GenServer.start_link(__MODULE__, args, name: via_tuple(name))
  end

  def init(_) do
    {:ok, nil}
  end

  def say_hello(name) do
    via_tuple(name)
    |> GenServer.call(:say_hello)
  end

  def handle_call(:say_hello, _from, state) do
    IO.puts("HELLO from node #{inspect(Node.self())}")
    # Process.send_after(self(), :say_hello, 5000)

    {:reply, :ok, state}
  end

  defp via_tuple(name), do: {:via, Horde.Registry, {HordesDemo.DistributedRegistry, name}}
end
