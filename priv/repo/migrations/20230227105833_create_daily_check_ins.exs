defmodule JResidence.Repo.Migrations.CreateDailyCheckIns do
  use Ecto.Migration

  def change do
    create table(:daily_check_ins, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :check_in, :date
      add :check_out, :date
      add :time_in, :time
      add :time_out, :time
      add :duration_day, :integer
      add :room_number, :string
      add :deposit, :decimal
      add :from, :string
      add :to, :string
      add :remarks, :string
      add :daily_customer_id, references(:daily_customers, on_delete: :nothing, type: :binary_id)
      add :daily_booking_id, references(:daily_bookings, on_delete: :nothing, type: :binary_id)
      add :room_id, references(:rooms, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:daily_check_ins, [:daily_customer_id])
    create index(:daily_check_ins, [:daily_booking_id])
    create index(:daily_check_ins, [:room_id])
  end
end
