defmodule BlogApiWeb.Controllers.UserControllerTest do
  use BlogApiWeb.ConnCase
  import BlogApiWeb.Auth.Guardian
  import BlogApi.Factory

  @valid_attrs %{
    display_name: "Name Displayed",
    email: "emailtest@gmail.com",
    password: "123456",
    image: "image"
  }

  @invalid_attrs %{
    display_name: "Name Displayed",
    password: "123456",
    image: "image"
  }

  @valid_login_attrs %{
    email: "emailtest@gmail.com",
    password: "123456"
  }

  @invalid_login_attrs %{
    email: "emailtest@gmail.com",
    password: "xxxxxx"
  }

  @email_is_required_message %{"message" => %{"email" => ["is required"]}}
  @user_already_existis_message %{"message" => "User already exists"}
  @user_already_existis_message %{"message" => "User already exists"}
  @user_not_found_message %{"message" => "User not found!"}

  describe "POST user/2" do
    test "when all params are valid, returns the token", %{conn: conn} do
      response =
        conn
        |> post(Routes.users_path(conn, :create, @valid_attrs))
        |> json_response(:ok)

      assert %{"token" => _token} = response
    end

    test "when there are invalid params, returns an error ", %{conn: conn} do
      response =
        conn
        |> post(Routes.users_path(conn, :create, @invalid_attrs))
        |> json_response(:unprocessable_entity)

      assert @email_is_required_message = response
    end

    test "when user already existis, returns an error", %{conn: conn} do
      BlogApi.create_user(@valid_attrs)

      response =
        conn
        |> post(Routes.users_path(conn, :create, @valid_attrs))
        |> json_response(:bad_request)

      assert @user_already_existis_message = response
    end
  end

  describe "POST login/2" do
    test "when login params are valid, returns a token", %{conn: conn} do
      BlogApi.create_user(@valid_attrs)

      response =
        conn
        |> post(Routes.users_path(conn, :login, @valid_login_attrs))
        |> json_response(:ok)

      assert %{"token" => _token} = response
    end

    test "when login params are invalid, returns an error", %{conn: conn} do
      response =
        conn
        |> post(Routes.users_path(conn, :login, @invalid_login_attrs))
        |> json_response(:bad_request)

      assert @user_not_found_message = response
    end
  end

  describe "GET api/user/:id" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      {:ok, conn: conn}
    end

    test "when get have invalids uuid, returns an error", %{conn: conn} do
      response =
        conn
        |> get(Routes.users_path(conn, :get, Ecto.UUID.generate()))
        |> json_response(:bad_request)

      assert @user_not_found_message = response
    end

    test "when get have valid uuid, returns an user", %{conn: conn} do
      user = insert(:user)

      response =
        conn
        |> get(Routes.users_path(conn, :get, user.id))
        |> json_response(:ok)

      assert user = response
    end
  end

  describe "GET api/user/" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      {:ok, conn: conn}
    end

    test "when get have a valid bearer token, returns an users list", %{conn: conn} do
      response =
        conn
        |> get(Routes.users_path(conn, :get))
        |> json_response(:ok)

      assert is_list(response)
    end
  end
end
