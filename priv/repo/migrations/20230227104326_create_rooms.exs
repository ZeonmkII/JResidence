defmodule JResidence.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :room_number, :string
      add :b_booked, :string
      add :b_occupied, :string
      add :floor_id, references(:floors, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:rooms, [:floor_id])
  end
end
