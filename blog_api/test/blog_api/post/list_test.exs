defmodule BloApi.Post.ListTest do
  use BlogApi.DataCase
  import BlogApi.Factory

  alias BlogApi.Post.List

  describe "call/1" do
    test "when database isnt empty, returns an post list" do
      post = insert(:post)
      response = List.call()

      assert [post] = response
    end

    test "when database is empty, returns an empty list" do
      response = List.call()

      assert [] = response
    end
  end
end
