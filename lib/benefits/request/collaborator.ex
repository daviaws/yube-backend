defmodule Benefits.Request.Collaborator do
  use Ecto.Schema
  import Ecto.Changeset

  schema "collaborators" do
    field :cpf, :string
    field :image, :string
    field :name, :string
    field :surname, :string

    timestamps()
  end

  @required [:name, :surname, :cpf, :image]

  @doc false
  def changeset(collaborator, attrs) do
    collaborator
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
