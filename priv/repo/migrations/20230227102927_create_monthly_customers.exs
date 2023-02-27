defmodule JResidence.Repo.Migrations.CreateMonthlyCustomers do
  use Ecto.Migration

  def change do
    create table(:monthly_customers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :b_contract, :string
      add :b_current, :string
      add :b_tenant, :string
      add :customer_id, references(:customers, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:monthly_customers, [:customer_id])
  end
end
