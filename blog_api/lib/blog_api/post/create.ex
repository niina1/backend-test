defmodule BlogApi.Post.Create do
  alias BlogApi.{Repo, Post}

  @moduledoc """
  Cria e insere posts no banco de dados.
  """

  @spec call(map()) ::
          {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()} | {:error, String.t()}
  def call(params) do
    params
    |> Post.build()
    |> create_post()
  end

  defp create_post({:ok, struct}) do
    Repo.insert(struct)
  end

  defp create_post({:error, _changeset} = error), do: error
end
