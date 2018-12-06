defmodule HordesDemo.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Horde.Registry, [name: HordesDemo.DistributedRegistry, keys: :unique]},
      {Horde.Supervisor, [name: HordesDemo.DistributedSupervisor, strategy: :one_for_one]},
      %{
        id: HordesDemo.ClusterConnector,
        restart: :transient,
        start: {HordesDemo.ClusterConnector, :start_link, [[]]}
      }
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
