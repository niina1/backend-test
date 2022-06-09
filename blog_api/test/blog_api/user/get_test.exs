defmodule BloApi.User.GetTest do
  use BlogApi.DataCase

  alias BlogApi.User.Get

  @valid_attrs %{
    display_name: "Name Displayed",
    email: "emailtest@gmail.com",
    password: "123456",
    image: "image"
  }

  @user_not_found_message {:error, "User not found!"}

  describe "call/1" do
    test "when uuid is valid, returns an user" do
      {:ok, user} = BlogApi.create_user(@valid_attrs)
      response = Get.call(user.id)

      assert {:ok, user} = response
    end

    test "when uuid is invalid, returns the error" do
      response = Get.call(Ecto.UUID.generate())

      assert @user_not_found_message == response
    end
  end
end
