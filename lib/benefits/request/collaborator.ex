defmodule Benefits.Request.Collaborator do
  use Ecto.Schema
  import Ecto.Changeset
  import Brcpfcnpj.Changeset

  schema "collaborators" do
    field :cpf, :string
    field :image, :string
    field :name, :string
    field :surname, :string
    field :benefit, BenefitsEnum

    timestamps()
  end

  @required [:name, :surname, :cpf, :benefit]
  @optional [:image]

  @doc false
  def changeset(collaborator, attrs) do
    collaborator
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> validate_length(:name, min: 3)
    |> validate_length(:surname, min: 3)
    |> validate_cpf(:cpf)
    |> unique_constraint(:cpf)
  end
end
