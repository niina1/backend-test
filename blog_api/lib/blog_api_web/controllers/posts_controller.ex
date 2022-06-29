defmodule BlogApiWeb.PostsController do
  use BlogApiWeb, :controller

  action_fallback(BlogApiWeb.FallbackController)

  def create(conn, params) do
    params = Map.put(params, "user_id", conn.assigns.user_id)

    with {:ok, post} <- BlogApi.create_post(params) do
      conn
      |> put_status(:ok)
      |> render("post_created.json", post: post)
    end
  end

  def get(conn, %{"id" => id}) do
    with {:ok, post} <- BlogApi.fetch_post(id) do
      conn
      |> put_status(:ok)
      |> render("post.json", %{posts: post})
    end
  end

  def get(conn, _params) do
    posts = BlogApi.list_posts()

    conn
    |> put_status(:ok)
    |> render("list_posts.json", %{posts: posts})
  end
end
