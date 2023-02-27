defmodule JResidence.Facilities.Building do
  alias JResidence.Facilities.Floor
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "buildings" do
    field :name, :string
    field :address, :string
    field :tax_id, :string
    field :phone, :string
    field :calc_type_water, :decimal
    field :calc_type_electric, :decimal
    field :unit_price_water, :decimal
    field :unit_price_eletric, :decimal

    has_many :floors, Floor

    timestamps()
  end

  @doc false
  def changeset(building, attrs) do
    building
    |> cast(attrs, [
      :name,
      :address,
      :tax_id,
      :phone,
      :calc_type_water,
      :calc_type_electric,
      :unit_price_water,
      :unit_price_eletric
    ])
    |> validate_required([
      :name,
      :address,
      :tax_id,
      :phone,
      :calc_type_water,
      :calc_type_electric,
      :unit_price_water,
      :unit_price_eletric
    ])
  end
end
