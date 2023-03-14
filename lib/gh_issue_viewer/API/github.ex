defmodule GhIssueViewer.API.Github do
  @moduledoc """
  Client used for getting Issues from Github
  """

  @method :get
  @issues_endpoint "/issues"

  def get_issues(org, project) do
    default_options = [
      base_url: config(:base_url),
      connect_options: [timeout: 15_000]
    ]

    [
      method: @method,
      url: "#{org}/#{project}#{config(:issues_path)}"
    ]
    |> Req.new()
    |> Req.Request.merge_options(default_options)
    |> Req.request!()
    |> case do
      %Req.Response{status: status, body: body} when status in 200..299 ->
        {:ok, body}

      %Req.Response{status: status, body: body} ->
        meta = %{
          response_status: status,
          response_body: body
        }

        {:error, meta}
    end
  end

  defp config(key), do: Application.get_env(:gh_issue_viewer, __MODULE__)[key]
end
