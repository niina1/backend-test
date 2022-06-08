defmodule BlogApiWeb.Auth.Pipeline do
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline, otp_app: :blog_api

  plug(Guardian.Plug.VerifyHeader, claims: @claims)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
