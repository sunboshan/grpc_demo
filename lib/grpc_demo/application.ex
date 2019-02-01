defmodule GRPCDemo.Application do
  use Application

  def start(:normal, []) do
    children = [
      {GRPC.Server.Supervisor, {Hello.Server, 9527}}
    ]

    opts = [strategy: :one_for_one, name: GRPCDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
