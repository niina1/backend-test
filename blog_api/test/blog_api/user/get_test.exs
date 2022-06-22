defmodule BloApi.User.GetTest do
  use BlogApi.DataCase
  import BlogApi.Factory

  alias BlogApi.User.Get

  @user_not_found_message {:error, "User not found!"}

  describe "call/1" do
    test "when uuid is valid, returns an user" do
      user = insert(:user)
      response = Get.call(user.id)

      assert {:ok, user} = response
    end

    test "when uuid is invalid, returns the error" do
      response = Get.call(Ecto.UUID.generate())

      assert @user_not_found_message == response
    end
  end
end
