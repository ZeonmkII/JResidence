defmodule JResidence.Repo.Migrations.CreateFloors do
  use Ecto.Migration

  def change do
    create table(:floors, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :floor_number, :string
      add :building_id, references(:buildings, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:floors, [:building_id])
  end
end
