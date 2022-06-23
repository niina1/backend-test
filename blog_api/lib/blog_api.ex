defmodule BlogApi do
  alias BlogApi.User

  defdelegate create_user(params), to: User.Create, as: :call

  defdelegate fetch_user(id), to: User.Get, as: :call

  defdelegate list_users(), to: User.List, as: :call

  defdelegate delete_user(id), to: User.Delete, as: :call
end
