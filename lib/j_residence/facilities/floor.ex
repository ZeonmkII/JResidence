defmodule JResidence.Facilities.Floor do
  alias JResidence.Facilities.Building
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "floors" do
    field :floor_number, :string

    belongs_to :building, Building

    timestamps()
  end

  @doc false
  def changeset(floor, attrs) do
    floor
    |> cast(attrs, [:floor_number])
    |> validate_required([:floor_number])
  end
end
