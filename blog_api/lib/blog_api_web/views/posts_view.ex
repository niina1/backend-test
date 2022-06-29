defmodule BlogApiWeb.PostsView do
  use BlogApiWeb, :view

  def render("post.json", %{post: post}) do
    %{
      title: post.title,
      content: post.content,
      user_id: post.user_id
    }
  end
end
