defmodule JResidence.Repo.Migrations.CreateDailyInvoices do
  use Ecto.Migration

  def change do
    create table(:daily_invoices, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :deposit, :decimal
      add :keycard_fees, :decimal
      add :other_labels, :string
      add :other_fees, :decimal
      add :remaining, :decimal
      add :total, :decimal
      add :daily_check_in_id, references(:daily_check_ins, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:daily_invoices, [:daily_check_in_id])
  end
end
