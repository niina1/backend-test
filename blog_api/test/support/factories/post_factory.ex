defmodule BlogApi.PostFactory do
  defmacro __using__(_opts) do
    quote do
      def post_factory do
        %BlogApi.Post{
          title: "Post Title!",
          content: "Post Content",
          user: build(:user)
        }
      end
    end
  end
end
