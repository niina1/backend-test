defmodule BlogApiWeb.PostsController do
  use BlogApiWeb, :controller

  action_fallback(BlogApiWeb.FallbackController)

  def create(conn, params) do
    params = Map.put(params, "user_id", conn.assigns.user_id)

    with {:ok, post} <- BlogApi.create_post(params) do
      conn
      |> put_status(:ok)
      |> render("post.json", post: post)
    end
  end
end
