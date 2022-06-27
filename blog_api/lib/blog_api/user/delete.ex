defmodule BlogApi.User.Delete do
  alias BlogApi.Repo

  def call(id) do
    with {:ok, user} <- BlogApi.fetch_user(id) do
      Repo.delete(user)
    end
  end
end
