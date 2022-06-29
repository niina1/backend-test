defmodule BloApi.Post.GetTest do
  use BlogApi.DataCase
  import BlogApi.Factory

  alias BlogApi.Post.Get

  @post_not_found_message {:error, "Post not found!"}

  describe "call/1" do
    test "when uuid is valid, returns a post" do
      post = insert(:post)
      response = Get.call(post.id)

      assert {:ok, post} = response
    end

    test "when uuid is invalid, returns the error" do
      response = Get.call(Ecto.UUID.generate())

      assert @post_not_found_message == response
    end
  end
end
