defmodule RealtimeChatWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :realtime_chat

  @session_options [
    store: :cookie,
    key: "_realtime_chat_key",
    signing_salt: "lnYzde+D",
    same_site: "Lax"
  ]

  ## 🔹 SOCKET DO CHAT (CHANNELS)
  socket "/socket", RealtimeChatWeb.UserSocket,
    websocket: true,
    longpoll: false

  ## 🔹 LIVEVIEW (já existia)
  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  plug Plug.Static,
    at: "/",
    from: :realtime_chat,
    gzip: not code_reloading?,
    only: RealtimeChatWeb.static_paths(),
    raise_on_missing_only: code_reloading?

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :realtime_chat
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug RealtimeChatWeb.Router
end
