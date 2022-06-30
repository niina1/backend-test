defmodule BlogApi.Post.Get do
  alias BlogApi.{Post, Repo}
  alias Ecto.UUID

  @moduledoc """
  Busca Posts no banco de dados pelo id
  """

  @spec call(integer()) :: Post.t()
  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Post, uuid) |> Repo.preload(:user) do
      nil -> {:error, "Post not found!"}
      post -> {:ok, post}
    end
  end
end
