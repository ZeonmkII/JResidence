defmodule JResidence.Repo.Migrations.CreateMonthlyContractFees do
  use Ecto.Migration

  def change do
    create table(:monthly_contract_fees, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :deposit, :decimal
      add :advance_payment, :decimal
      add :keycard_fees, :decimal
      add :other_labels, :string
      add :other_fees, :decimal
      add :total, :decimal
      add :monthly_contract_id, references(:monthly_contracts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:monthly_contract_fees, [:monthly_contract_id])
  end
end
