defmodule GcloudElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
   import Supervisor.Spec, warn: false

    IO.puts("Starting http")
    # Define workers and child supervisors to be supervised
    children = [
      worker(GcloudElixir.Engine, [])
    ]

    opts = [strategy: :one_for_one, name: Gcloudelixir.Supervisor]
    Supervisor.start_link(children, opts)

  end
end
