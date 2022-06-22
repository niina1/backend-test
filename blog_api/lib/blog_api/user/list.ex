defmodule BlogApi.User.List do
  alias BlogApi.{User, Repo}

  @moduledoc """
  Busca todos Users no banco de dados
  """

  @spec call() :: [User.t()] | list()
  def call() do
    Repo.all(User)
  end
end
