defmodule BlogApi.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias BlogApi.User

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "posts" do
    field(:title, :string)
    field(:content, :string)
    belongs_to(:user, User)
    timestamps(inserted_at: :published, updated_at: :updated)
  end

  @doc """
   Verifica se os parametros de criação do post atendem aos requisitos do changeset
  """
  @spec build(map()) :: Ecto.Schema.t() | Ecto.Changeset.t()
  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  @required_params [:title, :content, :user_id]
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
