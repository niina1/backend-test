defmodule BlogApi.Factory do
  use ExMachina.Ecto, repo: BlogApi.Repo
  use BlogApi.UserFactory
end
