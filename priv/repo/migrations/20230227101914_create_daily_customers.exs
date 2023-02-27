defmodule JResidence.Repo.Migrations.CreateDailyCustomers do
  use Ecto.Migration

  def change do
    create table(:daily_customers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :b_current, :string
      add :customer_id, references(:customers, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:daily_customers, [:customer_id])
  end
end
