defmodule JResidence.Repo.Migrations.CreateMonthlyInvoices do
  use Ecto.Migration

  def change do
    create table(:monthly_invoices, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :bill_cycle, :date
      add :advanced_payment, :decimal
      add :water_start, :decimal
      add :water_end, :decimal
      add :water_unit, :decimal
      add :electric_start, :decimal
      add :electric_end, :decimal
      add :other_labels, :string
      add :other_fees, :decimal
      add :total, :decimal
      add :monthly_contract_id, references(:monthly_contracts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:monthly_invoices, [:monthly_contract_id])
  end
end
