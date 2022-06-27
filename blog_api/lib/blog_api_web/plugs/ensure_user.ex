defmodule BlogApiWeb.Plugs.EnsureUser do
  @moduledoc """
  Plug responsável por atribuir o user_id do usuário autenticado
  """

  import Plug.Conn
  alias BlogApiWeb.Auth.Guardian

  def init(_opts), do: :ok

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, user, _claims} = Guardian.resource_from_token(token) do
      conn
      |> assign(:user_id, user.id)
    else
      _ ->
        conn
        |> send_resp(:unauthorized, "Invalid token")
        |> halt()
    end
  end
end
