defmodule Benefits.Repo.Migrations.Test do
  use Ecto.Migration

  def change do
    alter table(:collaborators) do
      add :benefit, :integer, null: false
    end
  end
end
