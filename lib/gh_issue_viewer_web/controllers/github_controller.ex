defmodule GhIssueViewerWeb.GithubController do
  use GhIssueViewerWeb, :controller

  alias GhIssueViewer.API.Github
  alias GhIssueViewer.Github.Issue

  def search(conn, %{"org_name" => org, "repo_name" => repo}) do
    {:ok, issues} = Github.get_issues(org, repo)

    conn
    |> assign(:issues, list_issue(issues))
    |> render("index.html")
  end

  # def live_search()

  defp list_issue(issues) do
    Enum.map(issues, fn issue ->
      case Issue.changeset(%Issue{}, issue) do
        %{valid?: true} = changeset ->
          changeset
          |> Ecto.Changeset.apply_changes()
          |> Map.put(:id, issue |> Map.get("id"))
          |> Map.put(:number, issue |> Map.get("number"))

        _changeset ->
          :error
      end
    end)
  end
end
