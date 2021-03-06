# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phello,
  ecto_repos: [Phello.Repo]

# Configures the endpoint
config :phello, PhelloWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OhHa673Zi+tIx2FEvgTCrcAMO2b06QwZ1+Ks8CEQ+BE7hebPNJitGMUP82+OdXqz",
  render_errors: [view: PhelloWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhelloWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
