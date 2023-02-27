defmodule JResidence.Facilities.Building do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "buildings" do
    field :address, :string
    field :calc_type_electric, :decimal
    field :calc_type_water, :decimal
    field :name, :string
    field :phone, :string
    field :tax_id, :string
    field :unit_price_eletric, :decimal
    field :unit_price_water, :decimal

    timestamps()
  end

  @doc false
  def changeset(building, attrs) do
    building
    |> cast(attrs, [:name, :address, :tax_id, :phone, :calc_type_water, :calc_type_electric, :unit_price_water, :unit_price_eletric])
    |> validate_required([:name, :address, :tax_id, :phone, :calc_type_water, :calc_type_electric, :unit_price_water, :unit_price_eletric])
  end
end
