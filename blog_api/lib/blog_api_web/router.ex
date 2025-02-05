defmodule BlogApiWeb.Router do
  use BlogApiWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :auth do
    plug(BlogApiWeb.Auth.Pipeline)
  end

  pipeline :ensure_user do
    plug(BlogApiWeb.Plugs.EnsureUser)
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard("/dashboard", metrics: BlogApiWeb.Telemetry)
    end
  end

  scope "/api", BlogApiWeb do
    pipe_through(:api)

    post("/user", UsersController, :create)

    post("/login", UsersController, :login)

    pipe_through(:auth)

    get("/user", UsersController, :get)

    get("/user/:id", UsersController, :get)

    pipe_through(:ensure_user)

    delete("/user", UsersController, :delete)

    post("/post", PostsController, :create)

    get("/post", PostsController, :get)

    get("/post/:id", PostsController, :get)
  end
end
