defmodule BloApi.Post.CreateTest do
  use BlogApi.DataCase
  import BlogApi.Factory

  alias BlogApi.{Repo, Post}
  alias Post.Create

  @valid_attrs %{
    title: "Title Content",
    content: "Post Content"
  }

  @invalid_attrs %{
    title: "Title Content"
  }

  @content_and_user_cant_be_blank_message %{
    user_id: ["can't be blank"],
    content: ["can't be blank"]
  }

  describe "call/1" do
    test "when all params are valid, creates an post" do
      user = insert(:user)
      valid_attrs = Map.put(@valid_attrs, :user_id, user.id)

      count_before = Repo.aggregate(Post, :count)

      response = Create.call(valid_attrs)

      count_after = Repo.aggregate(Post, :count)

      assert {:ok, valid_attrs} = response
      assert count_after > count_before
    end

    test "when there are invalid params, returns an error" do
      response = Create.call(@invalid_attrs)

      assert {:error, changeset} = response
      assert errors_on(changeset) == @content_and_user_cant_be_blank_message
    end
  end
end
