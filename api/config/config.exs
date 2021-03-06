# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :rv2,
  ecto_repos: [Rv2.Repo]

# Configures the endpoint
config :rv2, Rv2Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "A6v0toOtOCRGe0U8ZdaR5CrY4VP4jauJjzzqtZrLxnvOrTTa6KqtR8/y6oqb02Vx",
  render_errors: [view: Rv2Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: Rv2.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Guardian
config :guardian, Guardian,
  secret_key: System.get_env("GUARDIAN_SECRET_KEY"),
  issuer: "Rv2",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: Sling.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
