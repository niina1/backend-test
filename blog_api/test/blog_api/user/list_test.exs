defmodule BloApi.User.ListTest do
  use BlogApi.DataCase
  import BlogApi.Factory

  alias BlogApi.User.List

  describe "call/1" do
    test "when database isnt empty, returns an user list" do
      user = insert(:user)
      response = List.call()

      assert [user] = response
    end

    test "when database is empty, returns an empty list" do
      response = List.call()

      assert [] = response
    end
  end
end
