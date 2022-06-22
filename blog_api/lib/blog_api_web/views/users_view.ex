defmodule BlogApiWeb.UsersView do
  use BlogApiWeb, :view

  def render("login.json", %{token: token}) do
    %{token: token}
  end

  def render("list_users.json", %{users: users}) do
    render_many(users, __MODULE__, "user.json")
  end

  def render("user.json", %{users: user}) do
    %{
      id: user.id,
      display_name: user.display_name,
      email: user.email,
      image: user.image
    }
  end
end
