defmodule GcloudElixir.Engine do
  use Plug.Router
  require Logger

  if Mix.env() == :dev do
    use Plug.Debugger, otp_app: :http
  end

  plug(Plug.Logger)

  plug(
    Plug.Parsers,
    parsers: [:urlencoded, :json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  def init(options) do
    options
  end

  def start_link do
    port = Application.get_env(:gcloud_elixir, :port)

    port =
      case is_integer(port) do
        true -> port
        false -> String.to_integer(port)
      end

    {:ok, _} = Plug.Adapters.Cowboy.http(GcloudElixir.Engine, [], port: port, ip: {0, 0, 0, 0})
  end

  post "/" do
    conn
    |> send_resp(200, "OK")
    |> halt
  end

  get "/status" do
    send_resp(conn, 200, Jason.encode!(%{status: "ok", app_version: "prod"}))
  end

  match _ do
    conn
    |> send_resp(404, "Not Found.")
    |> halt
  end
end

