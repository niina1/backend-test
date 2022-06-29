defmodule BlogApi.Post.List do
  alias BlogApi.{Post, Repo}

  @moduledoc """
  Busca todos Posts no banco de dados
  """

  @spec call() :: [Post.t()] | list()
  def call() do
    Repo.all(Post)
    |> Repo.preload(:user)
  end
end
