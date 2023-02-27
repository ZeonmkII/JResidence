defmodule JResidence.Repo.Migrations.CreateMonthlyBookings do
  use Ecto.Migration

  def change do
    create table(:monthly_bookings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :check_in, :date
      add :check_out, :date
      add :duration_month, :integer
      add :duration_day, :integer
      add :remarks, :string
      add :rent_fees, :decimal
      add :service_fees, :decimal
      add :deposit, :decimal
      add :advance_payment, :decimal
      add :keycard_fees, :decimal
      add :other_labels, :string
      add :other_fees, :decimal
      add :remaining, :decimal
      add :total, :decimal
      add :monthly_customer_id, references(:monthly_customers, on_delete: :nothing, type: :binary_id)
      add :room_id, references(:rooms, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:monthly_bookings, [:monthly_customer_id])
    create index(:monthly_bookings, [:room_id])
  end
end
