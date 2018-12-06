defmodule HordesDemo.ClusterConnector do
  use GenServer

  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, [])
  end

  def init(_) do
    nodes = Node.list()

    Enum.each(nodes, fn node ->
      join_cluster(node)
    end)

    schedule_join()

    {:ok, nodes}
  end

  def handle_info(:join_cluster, nodes) do
    new_nodes = Node.list()

    (new_nodes -- nodes)
    |> Enum.each(fn node ->
      Logger.info("joining node #{inspect(node)}")
      join_cluster(node)
    end)

    schedule_join()

    {:noreply, new_nodes}
  end

  defp schedule_join() do
    Process.send_after(self(), :join_cluster, 5000)
  end

  defp join_cluster(node) do
    Horde.Cluster.join_hordes(
      HordesDemo.DistributedSupervisor,
      {HordesDemo.DistributedSupervisor, node}
    )

    Horde.Cluster.join_hordes(
      HordesDemo.DistributedRegistry,
      {HordesDemo.DistributedRegistry, node}
    )
  end
end
