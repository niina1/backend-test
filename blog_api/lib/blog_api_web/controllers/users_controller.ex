defmodule BlogApiWeb.UsersController do
  use BlogApiWeb, :controller

  alias BlogApiWeb.Auth.Guardian
  require Logger

  action_fallback(BlogApiWeb.FallbackController)

  def create(conn, params) do
    with {:ok, user} <- BlogApi.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:ok)
      |> render("login.json", %{token: token})
    end
  end

  def login(conn, params) do
    with :ok <- validate_params(params, "email"),
         :ok <- validate_params(params, "password"),
         {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("login.json", %{token: token})
    end
  end

  def get(conn, _params) do
    users = BlogApi.list_users()

    conn
    |> put_status(:ok)
    |> render("list_users.json", %{users: users})
  end

  defp validate_params(params, key) do
    case Map.fetch(params, key) do
      {:ok, nil} -> {:error, "\"#{key}\" is required"}
      {:ok, ""} -> {:error, "\"#{key}\" can't be blank"}
      :error -> {:error, "\"#{key}\" is required"}
      {:ok, _value} -> :ok
    end
  end
end
