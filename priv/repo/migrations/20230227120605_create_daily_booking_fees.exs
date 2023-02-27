defmodule JResidence.Repo.Migrations.CreateDailyBookingFees do
  use Ecto.Migration

  def change do
    create table(:daily_booking_fees, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :booking_fees, :decimal
      add :deposit, :decimal
      add :room_fees, :decimal
      add :other_labels, :string
      add :other_fees, :decimal
      add :remaining, :decimal
      add :total, :decimal
      add :daily_booking_id, references(:daily_bookings, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:daily_booking_fees, [:daily_booking_id])
  end
end
