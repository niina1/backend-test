defmodule BlogApiWeb.PostsView do
  use BlogApiWeb, :view

  def render("post_created.json", %{post: post}) do
    %{
      title: post.title,
      content: post.content,
      user_id: post.user_id
    }
  end

  def render("list_posts.json", %{posts: posts}) do
    render_many(posts, __MODULE__, "post.json")
  end

  def render("post.json", %{posts: post}) do
    %{
      id: post.id,
      published: post.published,
      updated: post.updated,
      title: post.title,
      content: post.content,
      user: %{
        id: post.user.id,
        display_name: post.user.display_name,
        email: post.user.email,
        image: post.user.image
      }
    }
  end
end
