defmodule JResidence.Repo.Migrations.CreateBuildings do
  use Ecto.Migration

  def change do
    create table(:buildings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :address, :string
      add :tax_id, :string
      add :phone, :string
      add :calc_type_water, :decimal
      add :calc_type_electric, :decimal
      add :unit_price_water, :decimal
      add :unit_price_eletric, :decimal

      timestamps()
    end
  end
end
