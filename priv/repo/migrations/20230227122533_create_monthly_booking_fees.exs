defmodule JResidence.Repo.Migrations.CreateMonthlyBookingFees do
  use Ecto.Migration

  def change do
    create table(:monthly_booking_fees, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :booking_fees, :decimal
      add :deposit, :decimal
      add :room_fees, :decimal
      add :other_labels, :string
      add :other_fees, :decimal
      add :remaining, :decimal
      add :total, :decimal
      add :monthly_booking_id, references(:monthly_bookings, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:monthly_booking_fees, [:monthly_booking_id])
  end
end
