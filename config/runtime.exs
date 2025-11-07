import Config

# Enable server only when PHX_SERVER=true is set.
# if System.get_env("PHX_SERVER") do
config :tes, TesWeb.Endpoint, server: true
# end

# Runtime config applies to all environments,
# but the block below is for :prod only.
if config_env() == :prod do
  #############################################
  # DATABASE CONFIG (local Postgres)
  #############################################

  db_user =
    System.get_env("DB_USER") ||
      raise """
      environment variable DB_USER is missing.
      """

  db_pass =
    System.get_env("DB_PASS") ||
      raise """
      environment variable DB_PASS is missing.
      """

  db_name =
    System.get_env("DB_NAME") ||
      raise """
      environment variable DB_NAME is missing.
      """

  db_host = System.get_env("DB_HOST") || "localhost"

  config :tes, Tes.Repo,
    username: db_user,
    password: db_pass,
    hostname: db_host,
    database: db_name,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

  #############################################
  # SECRET KEY BASE
  #############################################

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      Run: mix phx.gen.secret
      """

  #############################################
  # ENDPOINT + PORT
  #############################################

  host = System.get_env("PHX_HOST") || "localhost"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :tes, TesWeb.Endpoint,
    url: [host: host, port: port],
    http: [
      ip: {0, 0, 0, 0},
      port: port
    ],
    check_origin: false,
    secret_key_base: secret_key_base

  config :logger, level: :debug
end
