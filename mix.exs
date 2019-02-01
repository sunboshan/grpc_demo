defmodule GRPCDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :grpc_demo,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {GRPCDemo.Application, []}
    ]
  end

  defp deps do
    [
      {:grpc, "~> 0.3.1"}
    ]
  end
end
