defmodule JResidence.Facilities.Room do
  alias JResidence.Facilities.Floor
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "rooms" do
    field :room_number, :string
    field :b_booked, :string
    field :b_occupied, :string

    belongs_to :floor, Floor

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:room_number, :b_booked, :b_occupied])
    |> validate_required([:room_number])
  end
end
