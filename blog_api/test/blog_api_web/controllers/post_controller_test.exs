defmodule BlogApiWeb.Controllers.PostControllerTest do
  use BlogApiWeb.ConnCase
  import BlogApiWeb.Auth.Guardian
  import BlogApi.Factory

  @valid_attrs %{
    title: "Title Content",
    content: "Post Content"
  }

  @invalid_attrs %{
    title: "Title Content"
  }

  @post_not_found_message %{"message" => "Post not found!"}

  describe "POST api/post/" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      {:ok, conn: conn}
    end

    test "when have valid parameters, create and return the post", %{conn: conn} do
      response =
        conn
        |> post(Routes.posts_path(conn, :create, @valid_attrs))
        |> json_response(:ok)
    end

    test "when have invalid params, returns an error", %{conn: conn} do
      response =
        conn
        |> post(Routes.posts_path(conn, :create, @invalid_attrs))
        |> json_response(:unprocessable_entity)
    end

    test "when have an invalid bearer token, returns unauthorized", %{conn: conn} do
      conn = put_req_header(conn, "authorization", "Bearer 123}")

      response =
        conn
        |> post(Routes.posts_path(conn, :create, @valid_attrs))
        |> json_response(:unauthorized)
    end
  end

  describe "GET api/post/" do
    test "when get have a valid bearer token, returns an posts list", %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      response =
        conn
        |> get(Routes.posts_path(conn, :get))
        |> json_response(:ok)

      assert is_list(response)
    end

    test "when get have an invalid bearer token, returns unauthorized", %{conn: conn} do
      conn = put_req_header(conn, "authorization", "Bearer 123}")

      response =
        conn
        |> get(Routes.posts_path(conn, :get))
        |> json_response(:unauthorized)
    end
  end

  describe "GET api/post/:id" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      {:ok, conn: conn}
    end

    test "when get have invalids uuid, returns an error", %{conn: conn} do
      response =
        conn
        |> get(Routes.posts_path(conn, :get, Ecto.UUID.generate()))
        |> json_response(:bad_request)

      assert @post_not_found_message = response
    end

    test "when get have valid uuid, returns a post", %{conn: conn} do
      post = insert(:post)

      response =
        conn
        |> get(Routes.posts_path(conn, :get, post.id))
        |> json_response(:ok)

      assert post = response
    end
  end
end
