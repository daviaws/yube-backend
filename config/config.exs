# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :benefits,
  ecto_repos: [Benefits.Repo]

# Configures the endpoint
config :benefits, BenefitsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KHnd6NOhHmu2qEWue/cSlgEbUQzbJdcgXF2/Z6A8lGrX5FmZWD8/yuGs5inH2nRI",
  render_errors: [view: BenefitsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Benefits.PubSub,
  live_view: [signing_salt: "tiB87WVr"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
