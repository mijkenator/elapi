# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :elapi, Elapi.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "V7hAcR/FetWediOHuJNivoNVOD4hR7SlKkVO2FCvIC7VFIU/asfLuPHtbJHBWAz9",
  render_errors: [accepts: ~w(html json), default_format: "json"],
  pubsub: [name: Elapi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
#config :logger, :console,
#  format: "$time $metadata[$level] $message\n",
#  metadata: [:request_id]
backends = [:console, {LoggerFileBackend, :debug}, {LoggerFileBackend, :error}]
config :logger,
  format: "[$date] [$time] [$level] $metadata $message\n",
  metadata: [:request_id, :module, :line],
  backends: backends

config :logger, :console,
  level: :debug,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :logger, :debug,
  path: "/home/vagrant/elapi/log/debug.log",
  level: :debug,
  format: "[$date] [$time] [$level] $metadata $message\n",
  metadata: [:request_id, :date, :module, :line]

config :logger, :error,
  path: "/home/vagrant/elapi/log/error.log",
  level: :error,
  format: "[$date] [$time] [$level] $metadata $message\n",
  metadata: [:request_id, :date, :module, :line]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :ex_admin,
    repo: Elapi.Repo,
    module: Elapi,
    modules: [
        Elapi.ExAdmin.Dashboard,
        Elapi.ExAdmin.Users,
        Elapi.ExAdmin.Todos,
        Elapi.ExAdmin.Sessions,
        Elapi.ExAdmin.UserProperties
    ]

config :xain, :after_callback, {Phoenix.HTML, :raw}

config :guardian, Guardian,
  #allowed_algos: ["HS512"], # optional
  #verify_module: Guardian.JWT,  # optional
  issuer: "Elapi.#{Mix.env}",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "lksdjowiurowieurlkjsdlwwer",
  serializer: Elapi.GuardianSerializer,
  permissions: %{
    default: [
      :read_profile,
      :write_profile,
      :read_token,
      :revoke_token,
    ],
    admin: [:dashboard]
  }
  

