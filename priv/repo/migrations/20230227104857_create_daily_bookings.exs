defmodule JResidence.Repo.Migrations.CreateDailyBookings do
  use Ecto.Migration

  def change do
    create table(:daily_bookings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :check_in, :date
      add :check_out, :date
      add :duration_day, :integer
      add :remarks, :string
      add :daily_customer_id, references(:daily_customers, on_delete: :nothing, type: :binary_id)
      add :room_id, references(:rooms, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:daily_bookings, [:daily_customer_id])
    create index(:daily_bookings, [:room_id])
  end
end
