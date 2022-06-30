defmodule BlogApi do
  alias BlogApi.User
  alias BlogApi.Post

  defdelegate create_user(params), to: User.Create, as: :call

  defdelegate fetch_user(id), to: User.Get, as: :call

  defdelegate list_users(), to: User.List, as: :call

  defdelegate delete_user(id), to: User.Delete, as: :call

  defdelegate create_post(params), to: Post.Create, as: :call

  defdelegate fetch_post(id), to: Post.Get, as: :call

  defdelegate list_posts(), to: Post.List, as: :call
end
