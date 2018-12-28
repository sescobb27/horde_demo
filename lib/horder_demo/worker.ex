defmodule HordesDemo.Worker do
  use GenServer

  def start_link(args) do
    name = Keyword.get(args, :name, __MODULE__)
    GenServer.start_link(__MODULE__, args, name: via_tuple(name))
  end

  def init(args) do
    name = Keyword.get(args, :name, __MODULE__)
    Process.flag(:trap_exit, true)
    {:ok, name}
  end

  def say_hello(name) do
    via_tuple(name)
    |> GenServer.call(:say_hello)
  end

  def sync(name) do
    via_tuple(name)
    |> GenServer.cast(:sync)
  end

  def handle_call(:say_hello, _from, name) do
    IO.puts("HELLO from node: #{inspect(Node.self())} name: #{name}")
    {:reply, Node.self(), name}
  end

  def handle_cast(:sync, name) do
    IO.puts("SYNC within node: #{inspect(Node.self())} name: #{name}")
    {:noreply, name}
  end

  def terminate(reason, name) do
    IO.puts("Terminating node: #{inspect(Node.self())} reason: #{inspect(reason)} name: #{name}")
    sync(name)
  end

  defp via_tuple(name), do: {:via, Horde.Registry, {HordesDemo.DistributedRegistry, name}}
end
