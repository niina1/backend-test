defmodule BlogApi.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %BlogApi.User{
          display_name: "Name Displayed",
          email: sequence(:email, fn n -> "email-#{n}@example.com" end),
          password: "123456",
          image: "image"
        }
      end
    end
  end
end
