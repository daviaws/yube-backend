defmodule Benefits.Repo.Migrations.CreateCollaborators do
  use Ecto.Migration

  def change do
    create table(:collaborators) do
      add :name, :string, null: false
      add :surname, :string, null: false
      add :cpf, :string, null: false
      add :image, :string

      timestamps()
    end

    create unique_index(:collaborators, [:cpf])
  end
end
