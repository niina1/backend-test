defmodule BloApi.User.DeleteTest do
  use BlogApi.DataCase
  import BlogApi.Factory

  alias BlogApi.User.Delete

  @user_not_found_message {:error, "User not found!"}

  describe "call/1" do
    test "when uuid is valid, deletes an user" do
      user = insert(:user)
      response = Delete.call(user.id)

      assert {:ok, user} = response
    end

    test "when uuid is invalid, returns the error" do
      response = Delete.call(Ecto.UUID.generate())

      assert @user_not_found_message == response
    end
  end
end
