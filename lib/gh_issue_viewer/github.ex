defmodule GhIssueViewer.Github do

  @method :get
  @gh_endpoint "https://api.github.com/repos/"
  @issues_endpoint "/issues"

  def get_issues(org, project) do
    default_options = [
      base_url: config(:base_url),
      connect_options: [timeout: 15_000]
    ]

    [
      method: @method,
      url: "#{org}/#{project}#{@issues_endpoint}"
    ]
    |> Req.new()
    |> Req.Request.merge_options(default_options)
    |> Req.request!()

  end

  defp config(key), do: Application.get_env(:gh_issue_viewer, __MODULE__)[key]
end
