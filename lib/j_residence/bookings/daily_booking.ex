defmodule JResidence.Bookings.DailyBooking do
  alias JResidence.Facilities.Room
  alias JResidence.Tenants.DailyCustomer
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "daily_bookings" do
    field :check_in, :date
    field :check_out, :date
    field :duration_day, :integer
    field :remarks, :string

    belongs_to :daily_customer, DailyCustomer
    belongs_to :room, Room

    timestamps()
  end

  @doc false
  def changeset(daily_booking, attrs) do
    daily_booking
    |> cast(attrs, [:check_in, :check_out, :duration_day, :remarks])
    |> validate_required([:check_in, :check_out])
    |> add_duration()
  end

  defp add_duration(changeset) do
    check_in = get_field(changeset, :check_in)
    check_out = get_field(changeset, :check_out)

    case is_nil(check_in && check_out) do
      true -> changeset
      false -> put_change(changeset, :duration_day, Date.diff(check_out, check_in))
    end
  end
end
