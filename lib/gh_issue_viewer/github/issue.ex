defmodule GhIssueViewer.Github.Issue do
  @moduledoc """
  Schema for the issues. This could extend quite a lot, but for the scope of this project, we just need some minimal data
  The project does not use a database, so the embedded schema represents the data.
  """

  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:url, :string)
    field(:repository_url, :string)
    field(:title, :string)
    field(:html_url, :string)
  end

  def changeset(issue, attrs) do
    issue
    |> cast(attrs, [:url, :repository_url, :title, :html_url])
    |> validate_required([:url, :repository_url, :title, :html_url])
  end
end
