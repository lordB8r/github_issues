defmodule GhIssueViewer.Repo do
  use Ecto.Repo,
    otp_app: :gh_issue_viewer,
    adapter: Ecto.Adapters.Postgres
end
