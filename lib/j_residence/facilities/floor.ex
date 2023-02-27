defmodule JResidence.Facilities.Floor do
  alias JResidence.Facilities.{Building, Room}
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "floors" do
    field :floor_number, :string

    belongs_to :building, Building

    has_many :rooms, Room

    timestamps()
  end

  @doc false
  def changeset(floor, attrs) do
    floor
    |> cast(attrs, [:floor_number])
    |> validate_required([:floor_number])
  end
end
