import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :gh_issue_viewer, GhIssueViewer.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "gh_issue_viewer_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gh_issue_viewer, GhIssueViewerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "e5Ba1erQFbhZIdOJdTcrEQvK5lu9djIFhBCSzPJ96cyOidaKPTJKWfdM3mY4mxbM",
  server: false

# In test we don't send emails.
config :gh_issue_viewer, GhIssueViewer.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
