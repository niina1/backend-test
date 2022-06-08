defmodule BlogApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :blog_api

  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
