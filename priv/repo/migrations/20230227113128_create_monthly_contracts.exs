defmodule JResidence.Repo.Migrations.CreateMonthlyContracts do
  use Ecto.Migration

  def change do
    create table(:monthly_contracts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :date_signed, :date
      add :check_in, :date
      add :check_out, :date
      add :duration_month, :integer
      add :duration_day, :integer
      add :room_number, :string
      add :rent_fees, :decimal
      add :service_fees, :decimal
      add :deposit, :decimal
      add :advance_payment, :decimal
      add :keycard_fees, :decimal
      add :keycard_number, :string
      add :other_labels, :string
      add :other_fees, :decimal
      add :meter_water, :decimal
      add :meter_electric, :decimal
      add :remarks, :string
      add :monthly_customer_id, references(:monthly_customers, on_delete: :nothing, type: :binary_id)
      add :monthly_booking_id, references(:monthly_bookings, on_delete: :nothing, type: :binary_id)
      add :room_id, references(:rooms, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:monthly_contracts, [:monthly_customer_id])
    create index(:monthly_contracts, [:monthly_booking_id])
    create index(:monthly_contracts, [:room_id])
  end
end
